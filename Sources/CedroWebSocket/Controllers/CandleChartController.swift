import Foundation
import CedroWebSocketPresentation
import CedroWebSocketDomain
import CedroAuthentication

final class CandleChartController {
    static var instance: Self { Self() }
    private var response: ((GetCandleChart.Result) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    private var currentRequest: GetCandleChartModel?
    
    private lazy var presenter = { try? makeCandleChartPresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
    init() {
        semaphore.wait()
        Task {
            let result = await CedroAuthentication.shared.getLoginWebSocket()
            switch result {
            case .success(let loginWebSocket): tokenWebSocket = loginWebSocket.tokenWS
            case .failure(let error): response?(.failure(error))
            }
            semaphore.signal()
        }
    }
    
    deinit {
        unsubscribe()
        presenter = nil
    }
    
    func subscribe(_ symbol: String, period: ChartPeriodModel, realTime: Bool, quantity: Int? = 2, initDate: Date? = nil, response: ((GetCandleChart.Result) -> Void)? = nil, manager: ((CandleChartManager) -> Void)? = nil) {
        self.response = response
        currentSymbol = symbol
        semaphore.wait()
        presenter?.manager.observer = { [weak self] in
            if let presenterManager = self?.presenter?.manager { manager?(presenterManager) }
        }
        currentRequest = GetCandleChartModel(token: tokenWebSocket, quote: symbol, period: period, realTime: realTime, dispatch: .start, quantity: quantity, initDate: initDate)
        if let body = currentRequest { presenter?.candleChart(withBody: body) }
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        if let body = currentRequest {
            presenter?.candleChart(withBody: GetCandleChartModel(token: tokenWebSocket, quote: body.parameters.quote, period: body.parameters.period, realTime: body.parameters.realTime == "true", dispatch: .end))
        }
        semaphore.signal()
    }
}

extension CandleChartController: CandleChartPresenterDelegate {
    func candleChart(didReceive candleChartModel: CandleChartModel) {
        response?(.success(candleChartModel))
    }
    
    func candleChart(didReceive error: CedroError) { }
}

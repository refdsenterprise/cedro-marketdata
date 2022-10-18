import Foundation
import CedroWebSocketDomain

public protocol CandleChartPresenterDelegate {
    func candleChart(didReceive candleChartModel: CandleChartModel)
    func candleChart(didReceive error: CedroError)
}

public final class CandleChartPresenter {
    private let useCase: GetCandleChart
    private let delegate: CandleChartPresenterDelegate
    public let manager: CandleChartManager
    public private(set) var candleChartResponse: CandleChartModel?
    
    private let managerQueue = DispatchQueue(
        label: "cedro.websocket.candleChart.presenter.manager",
        qos: .background,
        attributes: .concurrent
    )
    
    public init(useCase: GetCandleChart, delegate: CandleChartPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
        manager = CandleChartManager.instance
    }
    
    public func candleChart(withBody body: GetCandleChartModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.candleChartResponse = model
                self.managerQueue.sync { self.manager.updateCandles(withNewValue: model) }
                self.delegate.candleChart(didReceive: model)
            case .failure(let error):
                self.delegate.candleChart(didReceive: error)
            }
        }
    }
}

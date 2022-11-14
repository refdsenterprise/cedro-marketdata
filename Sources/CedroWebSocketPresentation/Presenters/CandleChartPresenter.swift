import Foundation
import CedroWebSocketDomain

public protocol CandleChartPresenterDelegate {
    func candleChart(didReceive candleChartModel: CandleChartModel)
    func candleChart(didReceive error: CedroError)
}

public final class CandleChartPresenter {
    private let useCase: GetCandleChart
    private let delegate: CandleChartPresenterDelegate
    public let manager: CandleChartManager = .instance
    
    private let managerQueue = DispatchQueue(
        label: "cedro.websocket.candleChart.presenter.manager",
        qos: .background,
        attributes: .concurrent
    )
    
    public init(useCase: GetCandleChart, delegate: CandleChartPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func candleChart(withBody body: GetCandleChartModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.manager._response = model
                self.managerQueue.async { self.manager.update(withNewValue: model) }
                self.delegate.candleChart(didReceive: model)
            case .failure(let error):
                self.delegate.candleChart(didReceive: error)
            }
        }
    }
}
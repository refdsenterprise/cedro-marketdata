import Foundation
import CedroWebSocketPresentation

func makeCandleChartPresenter(delegate: CandleChartPresenterDelegate, token: String) throws -> CandleChartPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getCandleChart = try makeRemoteGetCandleChart(withCedroWebSocketClient: websocketClient, token: token)
    return CandleChartPresenter(useCase: getCandleChart, delegate: delegate)
}

import Foundation
import CedroMarketDataPresentation

func makeCandleChartPresenter(delegate: CandleChartPresenterDelegate, token: String) throws -> CandleChartPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getCandleChart = try makeRemoteGetCandleChart(withCedroMarketDataClient: websocketClient, token: token)
    return CandleChartPresenter(useCase: getCandleChart, delegate: delegate)
}

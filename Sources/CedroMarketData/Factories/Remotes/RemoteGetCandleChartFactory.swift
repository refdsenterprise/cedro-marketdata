import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetCandleChart(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetCandleChart {
    let remoteGetCandleChart = RemoteGetCandleChart(webSocketEndpoint: try CandleChartEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetCandleChart)
}

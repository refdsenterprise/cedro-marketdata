import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetCandleChart(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetCandleChart {
    let remoteGetCandleChart = RemoteGetCandleChart(webSocketEndpoint: try CandleChartEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetCandleChart)
}

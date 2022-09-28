import Foundation
import RefdsData
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetAggregatedBook(withWebSocketClient webSocketClient: WebSocketClient, token: String) -> GetAggregatedBook {
    let remoteGetAggregatedBook = RemoteGetAggregatedBook(webSocketEndpoint: AggregatedBookWebSocketEndpoint(queryItems: [.init(name: "reconnect", value: token.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetAggregatedBook)
}

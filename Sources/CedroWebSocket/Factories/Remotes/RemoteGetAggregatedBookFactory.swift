import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetAggregatedBook(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetAggregatedBook {
    let remoteGetAggregatedBook = RemoteGetAggregatedBook(webSocketEndpoint: try AggregatedBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetAggregatedBook)
}

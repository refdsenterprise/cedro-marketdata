import Foundation

func makeRemoteGetAggregatedBook(withWebSocketClient webSocketClient: WebSocketClient, token: String) -> GetAggregatedBook {
    let remoteGetAggregatedBook = RemoteGetAggregatedBook(url: makeURL(withPath: .ws, token: token, hasReconnect: true), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetAggregatedBook)
}

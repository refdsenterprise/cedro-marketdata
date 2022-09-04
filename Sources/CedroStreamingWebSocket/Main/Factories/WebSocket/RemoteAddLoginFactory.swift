import Foundation

func makeRemoteAddLogin(withWebSocketClient webSocketClient: WebSocketClient) -> RemoteAddLogin {
    return RemoteAddLogin(url: makeURL(withPath: .ws), webSocketClient: webSocketClient)
}

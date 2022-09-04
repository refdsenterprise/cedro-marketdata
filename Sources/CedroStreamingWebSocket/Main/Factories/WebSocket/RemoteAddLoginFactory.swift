import Foundation

func makeRemoteAddLogin(withWebSocketClient webSocketClient: WebSocketClient) -> AddLogin {
    let remoteAddLogin = RemoteAddLogin(url: makeURL(withPath: .ws), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteAddLogin)
}

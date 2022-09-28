import Foundation
import CedroWebSocketDomain
import CedroWebSocketData
import RefdsData

func makeRemoteAddLogin(withWebSocketClient webSocketClient: WebSocketClient) -> AddLogin {
    let remoteAddLogin = RemoteAddLogin(webSocketEndpoint: LoginWebSocketEndoint(), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteAddLogin)
}

import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetBusinessBook(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetBusinessBook {
    let remoteGetBusinessBook = RemoteGetBusinessBook(webSocketEndpoint: try BusinessBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetBusinessBook)
}

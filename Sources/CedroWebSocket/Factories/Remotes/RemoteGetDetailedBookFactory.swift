import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetDetailedBook(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetDetailedBook {
    let remoteGetDetailedBook = RemoteGetDetailedBook(webSocketEndpoint: try DetailedBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetDetailedBook)
}

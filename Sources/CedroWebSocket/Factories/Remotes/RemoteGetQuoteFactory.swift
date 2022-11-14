import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetQuote(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetQuote {
    let remoteGetQuote = RemoteGetQuote(webSocketEndpoint: try QuoteEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetQuote)
}

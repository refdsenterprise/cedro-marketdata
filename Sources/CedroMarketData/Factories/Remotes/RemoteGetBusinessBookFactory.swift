import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetBusinessBook(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetBusinessBook {
    let remoteGetBusinessBook = RemoteGetBusinessBook(webSocketEndpoint: try BusinessBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetBusinessBook)
}

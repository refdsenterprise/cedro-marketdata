import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetDetailedBook(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetDetailedBook {
    let remoteGetDetailedBook = RemoteGetDetailedBook(webSocketEndpoint: try DetailedBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetDetailedBook)
}

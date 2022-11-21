import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetAggregatedBook(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetAggregatedBook {
    let remoteGetAggregatedBook = RemoteGetAggregatedBook(webSocketEndpoint: try AggregatedBookEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetAggregatedBook)
}

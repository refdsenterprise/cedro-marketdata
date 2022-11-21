import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetQuote(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetQuote {
    let remoteGetQuote = RemoteGetQuote(webSocketEndpoint: try QuoteEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetQuote)
}

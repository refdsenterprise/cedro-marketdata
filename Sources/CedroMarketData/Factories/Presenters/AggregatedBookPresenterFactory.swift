import Foundation
import CedroMarketDataPresentation

func makeAggregatedBookPresenter(delegate: AggregatedBookPresenterDelegate, token: String) throws -> AggregatedBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getAggregatedBook = try makeRemoteGetAggregatedBook(withCedroMarketDataClient: websocketClient, token: token)
    return AggregatedBookPresenter(useCase: getAggregatedBook, delegate: delegate)
}

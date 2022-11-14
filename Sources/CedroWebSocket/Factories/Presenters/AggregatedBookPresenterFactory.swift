import Foundation
import CedroWebSocketPresentation

func makeAggregatedBookPresenter(delegate: AggregatedBookPresenterDelegate, token: String) throws -> AggregatedBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getAggregatedBook = try makeRemoteGetAggregatedBook(withCedroWebSocketClient: websocketClient, token: token)
    return AggregatedBookPresenter(useCase: getAggregatedBook, delegate: delegate)
}

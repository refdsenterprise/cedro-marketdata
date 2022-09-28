import Foundation
import CedroWebSocketPresentation

public func makeAggregatedBook(token: String, delegate: AggregatedBookDelegate) -> AggregatedBook {
    let websocketClient = makeNetworkAdapter()
    let getAggregatedBook = makeRemoteGetAggregatedBook(withWebSocketClient: websocketClient, token: token)
    return AggregatedBook(useCase: getAggregatedBook, delegate: delegate)
}

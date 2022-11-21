import Foundation
import CedroMarketDataPresentation

func makeDetailedBookPresenter(delegate: DetailedBookPresenterDelegate, token: String) throws -> DetailedBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getDetailedBook = try makeRemoteGetDetailedBook(withCedroMarketDataClient: websocketClient, token: token)
    return DetailedBookPresenter(useCase: getDetailedBook, delegate: delegate)
}

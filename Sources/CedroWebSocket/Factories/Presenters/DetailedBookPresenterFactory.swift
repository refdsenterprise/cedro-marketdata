import Foundation
import CedroWebSocketPresentation

func makeDetailedBookPresenter(delegate: DetailedBookPresenterDelegate, token: String) throws -> DetailedBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getDetailedBook = try makeRemoteGetDetailedBook(withCedroWebSocketClient: websocketClient, token: token)
    return DetailedBookPresenter(useCase: getDetailedBook, delegate: delegate)
}

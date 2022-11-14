import Foundation
import CedroWebSocketPresentation

func makeBusinessBookPresenter(delegate: BusinessBookPresenterDelegate, token: String) throws -> BusinessBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getBusinessBook = try makeRemoteGetBusinessBook(withCedroWebSocketClient: websocketClient, token: token)
    return BusinessBookPresenter(useCase: getBusinessBook, delegate: delegate)
}

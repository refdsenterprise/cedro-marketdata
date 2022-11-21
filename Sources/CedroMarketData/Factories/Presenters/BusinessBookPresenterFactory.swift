import Foundation
import CedroMarketDataPresentation

func makeBusinessBookPresenter(delegate: BusinessBookPresenterDelegate, token: String) throws -> BusinessBookPresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getBusinessBook = try makeRemoteGetBusinessBook(withCedroMarketDataClient: websocketClient, token: token)
    return BusinessBookPresenter(useCase: getBusinessBook, delegate: delegate)
}

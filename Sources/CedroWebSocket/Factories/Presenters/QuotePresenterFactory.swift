import Foundation
import CedroWebSocketPresentation

func makeQuotePresenter(delegate: QuotePresenterDelegate, token: String) throws -> QuotePresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getQuote = try makeRemoteGetQuote(withCedroWebSocketClient: websocketClient, token: token)
    return QuotePresenter(useCase: getQuote, delegate: delegate)
}

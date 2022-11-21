import Foundation
import CedroMarketDataPresentation

func makeQuotePresenter(delegate: QuotePresenterDelegate, token: String) throws -> QuotePresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getQuote = try makeRemoteGetQuote(withCedroMarketDataClient: websocketClient, token: token)
    return QuotePresenter(useCase: getQuote, delegate: delegate)
}

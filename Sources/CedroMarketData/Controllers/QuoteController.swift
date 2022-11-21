import Foundation
import CedroMarketDataPresentation
import CedroMarketDataDomain
import CedroAuthentication

final class QuoteController {
    static var instance: Self { Self() }
    private var response: ((_ quote: GetQuote.Result, _ updatedFields: [QuoteValuesModel.CodingKeys]) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    
    private lazy var presenter = { try? makeQuotePresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
    init() {
        semaphore.wait()
        Task {
            let result = await CedroAuthentication.shared.getLoginWebSocket()
            switch result {
            case .success(let loginWebSocket): tokenWebSocket = loginWebSocket.tokenWS
            case .failure(let error): response?(.failure(error), [])
            }
            semaphore.signal()
        }
    }
    
    deinit {
        unsubscribe()
        presenter = nil
    }
    
    func subscribe(_ symbol: String, response: ((_ quote: GetQuote.Result, _ updatedFields: [QuoteValuesModel.CodingKeys]) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.quote(
            withBody: GetQuoteModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .start))
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        presenter?.quote(
            withBody: GetQuoteModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .end))
        semaphore.signal()
    }
}

extension QuoteController: QuotePresenterDelegate {
    func quote(didReceive quoteModel: QuoteModel, updatedFields: [QuoteValuesModel.CodingKeys]) {
        response?(.success(quoteModel), updatedFields)
    }
    
    func quote(didReceive error: CedroError) { }
}

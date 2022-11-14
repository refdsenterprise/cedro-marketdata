import Foundation
import CedroWebSocketDomain

public protocol QuotePresenterDelegate {
    func quote(didReceive quoteModel: QuoteModel, updatedFields: [QuoteValuesModel.CodingKeys])
    func quote(didReceive error: CedroError)
}

public final class QuotePresenter {
    private let useCase: GetQuote
    private let delegate: QuotePresenterDelegate
    public private(set) var quoteResponse: QuoteModel?
    
    public init(useCase: GetQuote, delegate: QuotePresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func quote(withBody body: GetQuoteModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                if self.quoteResponse == nil { self.quoteResponse = model }
                let updatedFields = self.quoteResponse?.values.update(quote: model.values) ?? []
                if let quote = self.quoteResponse { self.delegate.quote(didReceive: quote, updatedFields: updatedFields) }
            case .failure(let error):
                self.delegate.quote(didReceive: error)
            }
        }
    }
}

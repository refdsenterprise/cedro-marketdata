import Foundation
import CedroMarketDataDomain

public protocol DetailedBookPresenterDelegate {
    func detailedBook(didReceive detailedBookModel: DetailedBookModel)
    func detailedBook(didReceive error: CedroError)
}

public final class DetailedBookPresenter {
    private let useCase: GetDetailedBook
    private let delegate: DetailedBookPresenterDelegate
    public private(set) var detailedBookResponse: DetailedBookModel?
    
    public init(useCase: GetDetailedBook, delegate: DetailedBookPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func detailedBook(withBody body: GetDetailedBookModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.detailedBookResponse = model
                self.delegate.detailedBook(didReceive: model)
            case .failure(let error):
                self.delegate.detailedBook(didReceive: error)
            }
        }
    }
}

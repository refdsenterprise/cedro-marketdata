import Foundation
import CedroWebSocketDomain

public protocol BusinessBookPresenterDelegate {
    func businessBook(didReceive businessBookModel: BusinessBookModel)
    func businessBook(didReceive error: CedroError)
}

public final class BusinessBookPresenter {
    private let useCase: GetBusinessBook
    private let delegate: BusinessBookPresenterDelegate
    public private(set) var businessBookResponse: BusinessBookModel?
    
    public init(useCase: GetBusinessBook, delegate: BusinessBookPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func businessBook(withBody body: GetBusinessBookModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.businessBookResponse = model
                self.delegate.businessBook(didReceive: model)
            case .failure(let error):
                self.delegate.businessBook(didReceive: error)
            }
        }
    }
}

import Foundation
import CedroWebSocketDomain

public protocol AggregatedBookPresenterDelegate {
    func aggregatedBook(didReceive aggregatedBookModel: AggregatedBookModel)
    func aggregatedBook(didReceive error: CedroError)
}

public final class AggregatedBookPresenter {
    private let useCase: GetAggregatedBook
    private let delegate: AggregatedBookPresenterDelegate
    public private(set) var aggregatedBookResponse: AggregatedBookModel?
    
    public init(useCase: GetAggregatedBook, delegate: AggregatedBookPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func aggregatedBook(withBody body: GetAggregatedBookModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.aggregatedBookResponse = model
                self.delegate.aggregatedBook(didReceive: model)
            case .failure(let error):
                self.delegate.aggregatedBook(didReceive: error)
            }
        }
    }
}

import Foundation
import CedroWebSocketDomain
import RefdsDomain

public protocol AggregatedBookDelegate {
    func aggregatedBook(didReceive aggregatedBookModel: AggregatedBookModel)
    func aggregatedBook(didReceive error: DomainError)
}

public extension AggregatedBookDelegate {
    func aggregatedBook(didReceive error: DomainError) {}
}

public final class AggregatedBook {
    private let useCase: GetAggregatedBook
    private let delegate: AggregatedBookDelegate
    public private(set) var aggregatedBookResponse: AggregatedBookModel?
    
    public init(useCase: GetAggregatedBook, delegate: AggregatedBookDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func aggregatedBook(withRequestModel getAggregatedBookModel: GetAggregatedBookModel) {
        useCase.get(getAggregatedBookModel: getAggregatedBookModel) { [weak self] result in
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

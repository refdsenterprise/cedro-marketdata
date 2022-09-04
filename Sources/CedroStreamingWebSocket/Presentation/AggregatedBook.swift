import Foundation

public protocol AggregatedBookDelegate {
    func aggregatedBook(didReceived aggregatedBookModel: AggregatedBookModel)
    func aggregatedBook(didReceived error: AggregatedBookError)
}

public extension AggregatedBookDelegate {
    func aggregatedBook(didReceived error: AggregatedBookError) {}
}

public final class AggregatedBook {
    private let useCase: GetAggregatedBook
    private let delegate: AggregatedBookDelegate
    public private(set) var aggregatedBookResponse: AggregatedBookModel?
    
    init(useCase: GetAggregatedBook, delegate: AggregatedBookDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func aggregatedBook(withRequestModel getAggregatedBookModel: GetAggregatedBookModel) {
        useCase.get(getAggregatedBookModel: getAggregatedBookModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.aggregatedBookResponse = model
                self.delegate.aggregatedBook(didReceived: model)
            case .failure(let error):
                self.delegate.aggregatedBook(didReceived: error)
            }
        }
    }
}

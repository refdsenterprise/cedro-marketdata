import Foundation
import CedroWebSocketDomain
import CedroWebSocketPresentation

class WeakProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

// MARK: - AggregatedBookPresenterDelegate
extension WeakProxy: AggregatedBookPresenterDelegate where T: AggregatedBookPresenterDelegate {
    func aggregatedBook(didReceive error: CedroError) {
        instance?.aggregatedBook(didReceive: error)
    }
    
    func aggregatedBook(didReceive aggregatedBookModel: AggregatedBookModel) {
        instance?.aggregatedBook(didReceive: aggregatedBookModel)
    }
}

// MARK: - AggregatedBookPresenterDelegate
extension WeakProxy: DetailedBookPresenterDelegate where T: DetailedBookPresenterDelegate {
    func detailedBook(didReceive error: CedroError) {
        instance?.detailedBook(didReceive: error)
    }
    
    func detailedBook(didReceive detailedBookModel: DetailedBookModel) {
        instance?.detailedBook(didReceive: detailedBookModel)
    }
}

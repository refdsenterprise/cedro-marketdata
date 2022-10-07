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

// MARK: - DetailedBookPresenterDelegate
extension WeakProxy: DetailedBookPresenterDelegate where T: DetailedBookPresenterDelegate {
    func detailedBook(didReceive error: CedroError) {
        instance?.detailedBook(didReceive: error)
    }
    
    func detailedBook(didReceive detailedBookModel: DetailedBookModel) {
        instance?.detailedBook(didReceive: detailedBookModel)
    }
}

// MARK: - BusinessBookPresenterDelegate
extension WeakProxy: BusinessBookPresenterDelegate where T: BusinessBookPresenterDelegate {
    func businessBook(didReceive error: CedroError) {
        instance?.businessBook(didReceive: error)
    }
    
    func businessBook(didReceive businessBookModel: BusinessBookModel) {
        instance?.businessBook(didReceive: businessBookModel)
    }
}

// MARK: - VolumeAtPricePresenterDelegate
extension WeakProxy: VolumeAtPricePresenterDelegate where T: VolumeAtPricePresenterDelegate {
    func volumeAtPrice(didReceive error: CedroError) {
        instance?.volumeAtPrice(didReceive: error)
    }
    
    func volumeAtPrice(didReceive volumeAtPriceModel: VolumeAtPriceModel) {
        instance?.volumeAtPrice(didReceive: volumeAtPriceModel)
    }
}

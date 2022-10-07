import Foundation
import CedroAuthentication
import CedroWebSocketDomain

public final class CedroWebSocket {
    public static let shared = CedroWebSocket()
    private let semaphore = DispatchSemaphore(value: 1)
    private let cedroAuthentication = CedroAuthentication.shared
    private var isCalledAuthentication = false
    
    init() { semaphore.wait() }
    
    public func start(username: String, password: String) {
        guard !isCalledAuthentication else { return }
        cedroAuthentication.start(username: username, password: password) { [weak self] status in
            switch status {
            case .logged: self?.semaphore.signal()
            case .unlogged: break
            }
        }
        isCalledAuthentication = true
    }
    
    public func aggregatedBook(_ symbol: String, response: @escaping (AggregatedBookModel) -> Void) {
        semaphore.wait()
        var controller: AggregatedBookController? = makeAggregatedBookController()
        controller?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let aggregatedBookModel): response(aggregatedBookModel)
            case .failure(_):
                controller = nil
                self?.aggregatedBook(symbol, response: response)
            }
        }
        semaphore.signal()
    }
    
    public func detailedBook(_ symbol: String, response: @escaping (DetailedBookModel) -> Void) {
        semaphore.wait()
        var controller: DetailedBookController? = makeDetailedBookController()
        controller?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let detailedBookModel): response(detailedBookModel)
            case .failure(_):
                controller = nil
                self?.detailedBook(symbol, response: response)
            }
        }
        semaphore.signal()
    }
    
    public func businessBook(_ symbol: String, response: @escaping (BusinessBookModel) -> Void) {
        semaphore.wait()
        var controller: BusinessBookController? = makeBusinessBookController()
        controller?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let businessBookModel): response(businessBookModel)
            case .failure(_):
                controller = nil
                self?.businessBook(symbol, response: response)
            }
        }
        semaphore.signal()
    }
    
    public func volumeAtPrice(_ symbol: String, response: @escaping (VolumeAtPriceModel) -> Void) {
        semaphore.wait()
        var controller: VolumeAtPriceController? = makeVolumeAtPriceController()
        controller?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let volumeAtPriceModel): response(volumeAtPriceModel)
            case .failure(_):
                controller = nil
                self?.volumeAtPrice(symbol, response: response)
            }
        }
        semaphore.signal()
    }
}

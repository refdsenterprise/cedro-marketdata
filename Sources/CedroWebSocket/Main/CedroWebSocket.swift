import Foundation
import CedroAuthentication
import CedroWebSocketDomain

public final class CedroWebSocket {
    public static let shared = CedroWebSocket()
    private let semaphore = DispatchSemaphore(value: 1)
    private let cedroAuthentication = CedroAuthentication.shared
    
    public init() {
        semaphore.wait()
        cedroAuthentication.start(username: "fasttrade", password: "102030") { [weak self] status in
            switch status {
            case .logged: self?.semaphore.signal()
            case .unlogged: break
            }
        }
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
}

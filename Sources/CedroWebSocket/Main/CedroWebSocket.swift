import Foundation
import CedroAuthentication
import CedroWebSocketDomain

public final class CedroWebSocket {
    public static let shared = CedroWebSocket()
    private let semaphore = DispatchSemaphore(value: 1)
    private let cedroAuthentication = CedroAuthentication.shared
    private var isCalledAuthentication = false
    
    private var aggregatedBookControllers = [String: AggregatedBookController]()
    private var detailedBookControllers = [String: DetailedBookController]()
    private var businessBookControllers = [String: BusinessBookController]()
    private var volumeAtPriceControllers = [String: VolumeAtPriceController]()
    
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
    
    public func subscribe(on service: CedroWebSocketService.Subscribe) {
        semaphore.wait()
        switch service {
        case .aggregatedBook(let symbol, let response): aggregatedBook(symbol, response: response)
        case .detailedBook(let symbol, let response): detailedBook(symbol, response: response)
        case .businessBook(let symbol, let response): businessBook(symbol, response: response)
        case .volumeAtPrice(let symbol, let response): volumeAtPrice(symbol, response: response)
        }
        semaphore.signal()
    }
    
    public func unsubscribe(on service: CedroWebSocketService.Unsubscribe) {
        semaphore.wait()
        switch service {
        case .aggregatedBook(let symbol): aggregatedBookControllers.removeValue(forKey: symbol.lowercased())
        case .detailedBook(let symbol): detailedBookControllers.removeValue(forKey: symbol.lowercased())
        case .businessBook(let symbol): businessBookControllers.removeValue(forKey: symbol.lowercased())
        case .volumeAtPrice(let symbol): volumeAtPriceControllers.removeValue(forKey: symbol.lowercased())
        }
        semaphore.signal()
    }
}

extension CedroWebSocket {
    func aggregatedBook(_ symbol: String, response: @escaping (AggregatedBookModel) -> Void) {
        aggregatedBookControllers[symbol.lowercased()] = makeAggregatedBookController()
        aggregatedBookControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let aggregatedBookModel): response(aggregatedBookModel)
            case .failure(_):
                self?.aggregatedBookControllers.removeValue(forKey: symbol.lowercased())
                self?.aggregatedBook(symbol, response: response)
            }
        }
    }
    
    func detailedBook(_ symbol: String, response: @escaping (DetailedBookModel) -> Void) {
        detailedBookControllers[symbol.lowercased()] = makeDetailedBookController()
        detailedBookControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let detailedBookModel): response(detailedBookModel)
            case .failure(_):
                self?.detailedBookControllers.removeValue(forKey: symbol.lowercased())
                self?.detailedBook(symbol, response: response)
            }
        }
    }
    
    func businessBook(_ symbol: String, response: @escaping (BusinessBookModel) -> Void) {
        businessBookControllers[symbol.lowercased()] = makeBusinessBookController()
        businessBookControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let businessBookModel): response(businessBookModel)
            case .failure(_):
                self?.businessBookControllers.removeValue(forKey: symbol.lowercased())
                self?.businessBook(symbol, response: response)
            }
        }
    }
    
    func volumeAtPrice(_ symbol: String, response: @escaping (VolumeAtPriceModel) -> Void) {
        volumeAtPriceControllers[symbol.lowercased()] = makeVolumeAtPriceController()
        volumeAtPriceControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let volumeAtPriceModel): response(volumeAtPriceModel)
            case .failure(_):
                self?.volumeAtPriceControllers.removeValue(forKey: symbol.lowercased())
                self?.volumeAtPrice(symbol, response: response)
            }
        }
    }
}

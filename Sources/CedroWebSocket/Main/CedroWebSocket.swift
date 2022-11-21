import Foundation
import CedroAuthentication
import CedroWebSocketDomain
import CedroWebSocketPresentation

public final class CedroWebSocket {
    public static let shared = CedroWebSocket()
    private let semaphore = DispatchSemaphore(value: 1)
    private let cedroAuthentication = CedroAuthentication.shared
    private var isCalledAuthentication = false
    
    private var aggregatedBookControllers = [String: AggregatedBookController]()
    private var detailedBookControllers = [String: DetailedBookController]()
    private var businessBookControllers = [String: BusinessBookController]()
    private var volumeAtPriceControllers = [String: VolumeAtPriceController]()
    private var quoteControllers = [String: QuoteController]()
    private var candleChartControllers = [String: CandleChartController]()
    
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
        case let .aggregatedBook(symbol, response): aggregatedBook(symbol, response: response)
        case let .detailedBook(symbol, response): detailedBook(symbol, response: response)
        case let .businessBook(symbol, response, manager): businessBook(symbol, response: response, manager: manager)
        case let .volumeAtPrice(symbol, response, manager): volumeAtPrice(symbol, response: response, manager: manager)
        case let .quote(symbol, response): quote(symbol, response: response)
        case let .candleChart(symbol, period, realTime, quantity, initDate, response, manager): candleChart(symbol, period: period, realTime: realTime, quantity: quantity, initDate: initDate, response: response, manager: manager)
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
        case .quote(let symbol): quoteControllers.removeValue(forKey: symbol.lowercased())
        case .candleChart(let symbol): candleChartControllers.removeValue(forKey: symbol.lowercased())
        }
        semaphore.signal()
    }
}

extension CedroWebSocket {
    func aggregatedBook(_ symbol: String, response: ((AggregatedBookModel) -> Void)? = nil) {
        aggregatedBookControllers[symbol.lowercased()] = makeAggregatedBookController()
        aggregatedBookControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let aggregatedBookModel): response?(aggregatedBookModel)
            case .failure(_):
                self?.aggregatedBookControllers.removeValue(forKey: symbol.lowercased())
                self?.aggregatedBook(symbol, response: response)
            }
        }
    }
    
    func detailedBook(_ symbol: String, response: ((DetailedBookModel) -> Void)? = nil) {
        detailedBookControllers[symbol.lowercased()] = makeDetailedBookController()
        detailedBookControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] result in
            switch result {
            case.success(let detailedBookModel): response?(detailedBookModel)
            case .failure(_):
                self?.detailedBookControllers.removeValue(forKey: symbol.lowercased())
                self?.detailedBook(symbol, response: response)
            }
        }
    }
    
    func businessBook(_ symbol: String, response: ((BusinessBookModel) -> Void)? = nil, manager: ((BusinessBookManager) -> Void)? = nil) {
        businessBookControllers[symbol.lowercased()] = makeBusinessBookController()
        businessBookControllers[symbol.lowercased()]?.subscribe(symbol, response: { [weak self] result in
            switch result {
            case.success(let businessBookModel): response?(businessBookModel)
            case .failure(_):
                self?.businessBookControllers.removeValue(forKey: symbol.lowercased())
                self?.businessBook(symbol, response: response)
            }
        }, manager: manager)
    }
    
    func volumeAtPrice(_ symbol: String, response: ((VolumeAtPriceModel) -> Void)? = nil, manager: ((VolumeAtPriceManager) -> Void)? = nil) {
        volumeAtPriceControllers[symbol.lowercased()] = makeVolumeAtPriceController()
        volumeAtPriceControllers[symbol.lowercased()]?.subscribe(symbol, response: { [weak self] result in
            switch result {
            case.success(let volumeAtPriceModel): response?(volumeAtPriceModel)
            case .failure(_):
                self?.volumeAtPriceControllers.removeValue(forKey: symbol.lowercased())
                self?.volumeAtPrice(symbol, response: response)
            }
        }, manager: manager)
    }
    
    func quote(_ symbol: String, response: ((_ quote: QuoteModel, _ updatedFields: [QuoteValuesModel.CodingKeys]) -> Void)? = nil) {
        quoteControllers[symbol.lowercased()] = makeQuoteController()
        quoteControllers[symbol.lowercased()]?.subscribe(symbol) { [weak self] quote, updatedFields in
            switch quote {
            case.success(let quoteModel): response?(quoteModel, updatedFields)
            case .failure(_):
                self?.quoteControllers.removeValue(forKey: symbol.lowercased())
                self?.quote(symbol, response: response)
            }
        }
    }
    
    func candleChart(_ symbol: String, period: ChartPeriodModel, realTime: Bool, quantity: Int? = 2, initDate: Date? = nil, response: ((CandleChartModel) -> Void)? = nil, manager: ((CandleChartManager) -> Void)? = nil) {
        candleChartControllers[symbol.lowercased()] = makeCandleChartController()
        candleChartControllers[symbol.lowercased()]?.subscribe(symbol, period: period, realTime: realTime, quantity: quantity, initDate: initDate, response: { [weak self] result in
            switch result {
            case .success(let candleChartModel): response?(candleChartModel)
            case .failure(_):
                self?.candleChartControllers.removeValue(forKey: symbol.lowercased())
                self?.candleChart(symbol, period: period, realTime: realTime, quantity: quantity, initDate: initDate, response: response)
            }
        }, manager: manager)
    }
}

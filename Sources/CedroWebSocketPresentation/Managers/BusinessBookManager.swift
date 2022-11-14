import Foundation
import CedroWebSocketDomain

public final class BusinessBookManager {
    static var instance: Self { Self() }
    private let mainQueue = DispatchQueue.main
    
    var _response: BusinessBookModel?
    private var _aggregatedBusinessBook: [Keys: BusinessBookTradeModel] = [:]
    
    public var observer: (() -> Void)?
    public var response: BusinessBookModel? { _response }
    public private(set) var aggregatedBusinessBook: [BusinessBookTradeModel] = []
    
    init() {}
    
    deinit {
        _aggregatedBusinessBook = [:]
    }
    
    public func get(fromKeys keys: Keys) -> [BusinessBookTradeModel] {
        return _aggregatedBusinessBook.filter({ $0.key.rawValue.contains(keys.rawValue) }).map({ $0.value })
    }
    
    func update(withNewValue newValue: BusinessBookModel) {
        newValue.quoteTrade.trades.forEach { [weak self] trade in
            if let aggressor = trade.aggressor, let broker = aggressor == .buyer ? trade.brokerBuyer : aggressor == .seller ? trade.brokerSeller : nil {
                let key = Keys.complete(symbol: newValue.quoteTrade.symbol, date: trade.date, dateFormat: .second, broker: broker, aggressor: aggressor)
                if let _ = self?._aggregatedBusinessBook[key] {
                    self?._aggregatedBusinessBook[key]?.amount += trade.amount
                    if aggressor == .buyer { self?._aggregatedBusinessBook[key]?.brokerSeller = nil }
                    else if aggressor == .seller { self?._aggregatedBusinessBook[key]?.brokerBuyer = nil }
                } else {
                    self?._aggregatedBusinessBook[key] = trade
                }
            }
        }
        
        aggregatedBusinessBook = Array(_aggregatedBusinessBook.values.sorted(by: { $0.date < $1.date }))
        
        mainQueue.async { [weak self] in self?.observer?() }
        
        if _aggregatedBusinessBook.values.count > 100 && aggregatedBusinessBook.count > 100 {
            Array(aggregatedBusinessBook[0 ... 49]).forEach { [weak self] in
                if let aggressor = $0.aggressor, let broker = aggressor == .buyer ? $0.brokerBuyer : aggressor == .seller ? $0.brokerSeller : nil {
                    let key = Keys.complete(symbol: newValue.quoteTrade.symbol, date: $0.date, dateFormat: .second, broker: broker, aggressor: aggressor)
                    self?._aggregatedBusinessBook.removeValue(forKey: key)
                }
            }
        }
    }
    
}

extension BusinessBookManager {
    public enum Keys: Hashable {
        case complete(symbol: String, date: Date, dateFormat: DateFormatKey, broker: Int, aggressor: BusinessBookTradeAggressorModel)
        
        public var rawValue: String {
            switch self {
            case let .complete(symbol, date, dateFormat, broker, aggressor): return "\(symbol.lowercased()).\(date.asString(withDateFormat: dateFormat.rawValue)).\(broker).\(aggressor.rawValue)"
            }
        }
    }
    
    public enum DateFormatKey: String {
        case second = "yyyyMMddHHmmss"
        case minute = "yyyyMMddHHmm"
        case hour = "yyyyMMddHH"
    }
}

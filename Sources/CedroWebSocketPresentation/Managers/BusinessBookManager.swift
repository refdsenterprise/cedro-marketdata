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
        for trade in newValue.quoteTrade.trades {
            if let aggressor = trade.aggressor, let broker = aggressor == .buyer ? trade.brokerBuyer : aggressor == .seller ? trade.brokerSeller : nil {
                let key = Keys.complete(symbol: newValue.quoteTrade.symbol, date: trade.date, dateFormat: .second, broker: broker, aggressor: aggressor)
                if let _ = _aggregatedBusinessBook[key] {
                    _aggregatedBusinessBook[key]?.amount += trade.amount
                    if aggressor == .buyer { _aggregatedBusinessBook[key]?.brokerSeller = nil }
                    else if aggressor == .seller { _aggregatedBusinessBook[key]?.brokerBuyer = nil }
                } else {
                    _aggregatedBusinessBook[key] = trade
                }
            }
        }
        
        aggregatedBusinessBook = Array(_aggregatedBusinessBook.values.sorted(by: { $0.date < $1.date }))
        
        if let last = newValue.quoteTrade.trades.last, _aggregatedBusinessBook.count > 100 {
            _ = _aggregatedBusinessBook.drop { trade in
                let interval = Int(trade.value.date.timeIntervalSince(last.date))
                return (interval / 60) % 60 > 3
            }
        }
        
        mainQueue.async { [weak self] in self?.observer?() }
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

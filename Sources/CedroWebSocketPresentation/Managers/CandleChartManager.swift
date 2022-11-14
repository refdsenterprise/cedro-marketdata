import Foundation
import CedroWebSocketDomain

public final class CandleChartManager {
    static var instance: Self { Self() }
    private let mainQueue = DispatchQueue.main
    
    var _response: CandleChartModel?
    private var _candles: [Keys: CandleModel] = [:]
    
    public var observer: (() -> Void)?
    public var response: CandleChartModel? { _response }
    public var candles: [CandleModel] { _candles.sorted(by: { $0.key.rawValue < $1.key.rawValue }).map({ $0.value }) }
    
    init() {}
    
    deinit {
        _candles = [:]
    }
    
    public func get(fromKeys keys: Keys) -> [CandleModel] {
        return _candles.filter({ $0.key.rawValue.contains(keys.rawValue) }).map({ $0.value })
    }
    
    func update(withNewValue newValue: CandleChartModel) {
        newValue.candles.forEach { [weak self] candle in
            let key = Keys.byDate(symbol: newValue.quote, period: newValue.period, date: candle.date, dateFormat: .minute)
            self?._candles[key] = candle
        }
        mainQueue.async { [weak self] in self?.observer?() }
    }
}

extension CandleChartManager {
    public enum Keys: Hashable {
        case byDate(symbol: String, period: ChartPeriodModel, date: Date, dateFormat: DateFormatKey)
        case byPeriod(symbol: String, period: ChartPeriodModel)
        
        public var rawValue: String {
            switch self {
            case let .byDate(symbol, period, date, dateFormat): return "\(symbol.lowercased()).\(period.rawValue).\(date.asString(withDateFormat: dateFormat.rawValue))."
            case let .byPeriod(symbol, period): return "\(symbol.lowercased()).\(period.rawValue)."
            }
        }
    }
    
    public enum DateFormatKey: String {
        case minute = "yyyyMMddHHmm"
        case hour = "yyyyMMddHH"
        case day = "yyyyMMdd"
        case month = "yyyyMM"
        case year = "yyyy"
    }
}

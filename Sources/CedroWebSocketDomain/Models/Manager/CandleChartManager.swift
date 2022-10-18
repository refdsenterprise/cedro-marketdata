import Foundation

public final class CandleChartManager {
    public static var instance: Self { Self() }
    public var observer: (() -> Void)?
    private var _candles: [Keys: CandleModel] = [:]
    private let mainQueue = DispatchQueue.main
    
    public var candles: [CandleModel] {
        _candles.sorted(by: { $0.key.rawValue < $1.key.rawValue }).map({ $0.value })
    }
    
    public init() {}
    
    deinit {
        _candles = [:]
    }
    
    public func getCandles(fromKeys keys: Keys) -> [CandleModel] {
        return _candles.filter({ $0.key.rawValue.contains(keys.rawValue) }).map({ $0.value })
    }
    
    public func updateCandles(withNewValue newValue: CandleChartModel) {
        newValue.candles.forEach { [weak self] candle in
            let key = Keys.byDate(newValue.quote, newValue.period, candle.date)
            self?._candles[key] = candle
        }
        mainQueue.async { [weak self] in self?.observer?() }
    }
}

extension CandleChartManager {
    public enum Keys: Hashable {
        case byDate(_ symbol: String, _ period: ChartPeriodModel, _ date: Date)
        case byPeriod(_ symbol: String, _ period: ChartPeriodModel)
        
        public var rawValue: String {
            switch self {
            case let .byDate(symbol, period, date): return "\(symbol.lowercased()).\(period.rawValue).\(date.asString(withDateFormat: "yyyyMMddHHmm"))."
            case let .byPeriod(symbol, period): return "\(symbol.lowercased()).\(period.rawValue)."
            }
        }
    }
}

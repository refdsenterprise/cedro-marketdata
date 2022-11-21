import Foundation
import CedroWebSocketDomain

public final class VolumeAtPriceManager {
    static var instance: Self { Self() }
    private let mainQueue = DispatchQueue.main
    
    var _response: VolumeAtPriceModel?
    private var _aggregatedVolumeAtPrice: [Keys: VolumeAtPriceValueModel] = [:]
    
    public var observer: (() -> Void)?
    public var response: VolumeAtPriceModel? { _response }
    public private(set) var aggregatedVolumeAtPrice: [VolumeAtPriceValueModel] = []
    
    init() {}
    
    deinit {
        _aggregatedVolumeAtPrice = [:]
    }
    
    public func get(fromKeys keys: Keys) -> [VolumeAtPriceValueModel] {
        return _aggregatedVolumeAtPrice.filter({ $0.key.rawValue.contains(keys.rawValue) }).map({ $0.value })
    }
    
    func update(withNewValue newValue: VolumeAtPriceModel) {
        newValue.values.forEach { [weak self] value in
            let key = Keys.complete(symbol: value.symbol, period: value.period, price: value.price.rounded(toPlaces: 5))
            self?._aggregatedVolumeAtPrice[key] = value
        }
        
        aggregatedVolumeAtPrice = Array(_aggregatedVolumeAtPrice.values.sorted(by: { $0.price < $1.price }))
        
        mainQueue.async { [weak self] in self?.observer?() }
    }
    
}

extension VolumeAtPriceManager {
    public enum Keys: Hashable {
        case complete(symbol: String, period: Double, price: Double)
        
        public var rawValue: String {
            switch self {
            case let .complete(symbol, period, price): return "\(symbol.lowercased()).\(period).\(price)"
            }
        }
    }
}

import Foundation

public struct VolumeAtPriceModel: CedroModel {
    public let values: [VolumeAtPriceValueModel]
}

public struct VolumeAtPriceValueModel: CedroModel {
    public let symbol: String
    public let price: Double
    public let businessQuantityBuy: Double?
    public let volumeBuy: Double?
    public let businessQuantitySell: Double?
    public let volumeSell: Double?
    public let businessQuantityDirect: Double?
    public let volumeDirect: Double?
    public let businessQuantityUndefined: Double?
    public let volumeUndefined: Double?
    public let period: Double
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case price
        case businessQuantityBuy
        case volumeBuy
        case businessQuantitySell
        case volumeSell
        case businessQuantityDirect
        case volumeDirect
        case businessQuantityUndefined
        case volumeUndefined
        case period
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try values.decode(String.self, forKey: .symbol)
        guard let price = try values.decode(String.self, forKey: .price).asDouble else { throw CedroError.decodedError(type: Self.self) }
        self.price = price
        businessQuantityBuy = try values.decodeIfPresent(String.self, forKey: .businessQuantityBuy)?.asDouble
        volumeBuy = try values.decodeIfPresent(String.self, forKey: .volumeBuy)?.asDouble
        businessQuantitySell = try values.decodeIfPresent(String.self, forKey: .businessQuantitySell)?.asDouble
        volumeSell = try values.decodeIfPresent(String.self, forKey: .volumeSell)?.asDouble
        businessQuantityDirect = try values.decodeIfPresent(String.self, forKey: .businessQuantityDirect)?.asDouble
        volumeDirect = try values.decodeIfPresent(String.self, forKey: .volumeDirect)?.asDouble
        businessQuantityUndefined = try values.decodeIfPresent(String.self, forKey: .businessQuantityUndefined)?.asDouble
        volumeUndefined = try values.decodeIfPresent(String.self, forKey: .volumeUndefined)?.asDouble
        guard let period = try values.decode(String.self, forKey: .period).asDouble else { throw CedroError.decodedError(type: Self.self) }
        self.period = period
    }
}

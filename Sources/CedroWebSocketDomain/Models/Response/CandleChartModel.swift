import Foundation

public struct CandleChartModel: CedroModel {
    public let quote: String
    public let period: ChartPeriodModel
    public var candles: [CandleModel]
}

public enum ChartPeriodModel: String, CedroModel {
    case oneMinute = "1"
    case fiveMinutes = "5"
    case tenMinutes = "10"
    case fifteenMinutes = "15"
    case thirtyMinutes = "30"
    case hour = "60"
    case day = "D"
}

public struct CandleModel: CedroModel {
    public var date: Date
    public var price: Double
    public var open: Double
    public var high: Double
    public var low: Double
    public var previous: Double?
    public var fVol: Double?
    public var aVol: Double?
    public var isClose: Bool
    
    public enum CodingKeys: String, CodingKey, CedroModel, CaseIterable {
        case date
        case price
        case open
        case high
        case low
        case previous
        case fVol
        case aVol
        case isClose
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let intDate = try values.decode(Int.self, forKey: .date)
        let stringDate = String(intDate)
        guard let date = stringDate.asDate(withFormat: "yyyyMMddHHmm") else { throw CedroError.decodedError(type: Self.self) }
        self.date = date
        price = try values.decode(Double.self, forKey: .price)
        open = try values.decode(Double.self, forKey: .open)
        high = try values.decode(Double.self, forKey: .high)
        low = try values.decode(Double.self, forKey: .low)
        let stringFVol = try values.decodeIfPresent(String.self, forKey: .fVol)
        fVol = stringFVol?.asDouble
        let stringAVol = try values.decodeIfPresent(String.self, forKey: .aVol)
        aVol = stringAVol?.asDouble
        isClose = try values.decode(Bool.self, forKey: .isClose)
    }
}

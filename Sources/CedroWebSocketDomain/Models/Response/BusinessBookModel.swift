import Foundation

public struct BusinessBookModel: CedroModel {
    public let quoteTrade: BusinessBookContentModel
    public let type: ContentType
    public let parameter: String
}

public struct BusinessBookContentModel: CedroModel {
    public let symbol: String
    public let trades: [BusinessBookTradeModel]
    
    public enum CodingKeys: String, CodingKey {
        case symbol = "M"
        case trades = "L"
    }
}

public struct BusinessBookTradeModel: CedroModel {
    public var amount: Double
    public var price: Double
    public var brokerBuyer: Int?
    public var brokerSeller: Int?
    public var aggressor: BusinessBookTradeAggressorModel?
    public var date: Date
    
    public enum CodingKeys: String, CodingKey {
        case amount = "QT"
        case price = "P"
        case brokerBuyer = "PCB"
        case brokerSeller = "PCL"
        case aggressor = "CDA"
        case date = "T"
    }
}

public enum BusinessBookTradeAggressorModel: String, CedroModel {
    case buyer = "A"
    case seller = "V"
    case undefined = "I"
    case removed = "R"
}

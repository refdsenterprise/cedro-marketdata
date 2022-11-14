import Foundation

public struct DetailedBookModel: CedroModel {
    public let book: DetailedBookContentModel
    public let type: ContentType
    public let parameter: String
}

public struct DetailedBookContentModel: CedroModel {
    public let symbol: String
    public let sell: [DetailedBookOfferModel]
    public let buy: [DetailedBookOfferModel]
    
    public enum CodingKeys: String, CodingKey {
        case symbol = "S"
        case sell = "B"
        case buy = "A"
    }
}

public struct DetailedBookOfferModel: CedroModel {
    public var amount: Double
    public var price: Double
    public var broker: Int?
    public var formattedAmount: String
    
    public enum CodingKeys: String, CodingKey {
        case amount = "Q"
        case price = "P"
        case broker = "C"
        case formattedAmount = "FQ"
    }
}

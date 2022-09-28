import Foundation
import RefdsDomain

public struct AggregatedBookModel: DomainModel {
    public let book: AggregatedBookContentModel
    public let type: ContentType
    public let parameter: String
}

public struct AggregatedBookContentModel: DomainModel {
    public let symbol: String
    public let sell: [AggregatedBookOfferModel]
    public let buy: [AggregatedBookOfferModel]
    
    public enum CodingKeys: String, CodingKey {
        case symbol = "S"
        case sell = "B"
        case buy = "A"
    }
}

public struct AggregatedBookOfferModel: DomainModel {
    public var amount: Double
    public var price: Double
    public var formattedAmount: String
    
    public enum CodingKeys: String, CodingKey {
        case amount = "Q"
        case price = "P"
        case formattedAmount = "FQ"
    }
}

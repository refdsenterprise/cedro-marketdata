import Foundation
import CedroWebSocketDomain

public enum CedroWebSocketService {
    public enum Subscribe {
        case aggregatedBook(_ symbol: String, response: (AggregatedBookModel) -> Void)
        case detailedBook(_ symbol: String, response: (DetailedBookModel) -> Void)
        case businessBook(_ symbol: String, response: (BusinessBookModel) -> Void)
        case volumeAtPrice(_ symbol: String, response: (VolumeAtPriceModel) -> Void)
        case quote(_ symbol: String, response: (_ quote: QuoteModel, _ updatedFields: [QuoteValuesModel.CodingKeys]) -> Void)
    }
    
    public enum Unsubscribe {
        case aggregatedBook(_ symbol: String)
        case detailedBook(_ symbol: String)
        case businessBook(_ symbol: String)
        case volumeAtPrice(_ symbol: String)
        case quote(_ symbol: String)
    }
}

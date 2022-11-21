import Foundation
import CedroWebSocketDomain
import CedroWebSocketPresentation

public enum CedroWebSocketService {
    public enum Subscribe {
        case aggregatedBook(_ symbol: String, response: ((AggregatedBookModel) -> Void)? = nil)
        case detailedBook(_ symbol: String, response: ((DetailedBookModel) -> Void)? = nil)
        case businessBook(_ symbol: String, response: ((BusinessBookModel) -> Void)? = nil, manager: ((BusinessBookManager) -> Void)? = nil)
        case volumeAtPrice(_ symbol: String, response: ((VolumeAtPriceModel) -> Void)? = nil, manager: ((VolumeAtPriceManager) -> Void)? = nil)
        case quote(_ symbol: String, response: ((_ quote: QuoteModel, _ updatedFields: [QuoteValuesModel.CodingKeys]) -> Void)? = nil)
        case candleChart(_ symbol: String, period: ChartPeriodModel, realTime: Bool, quantity: Int? = 2, initDate: Date? = nil, response: ((CandleChartModel) -> Void)? = nil, manager: ((CandleChartManager) -> Void)? = nil)
    }
    
    public enum Unsubscribe {
        case aggregatedBook(_ symbol: String)
        case detailedBook(_ symbol: String)
        case businessBook(_ symbol: String)
        case volumeAtPrice(_ symbol: String)
        case quote(_ symbol: String)
        case candleChart(_ symbol: String)
    }
}

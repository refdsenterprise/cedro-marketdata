import Foundation

public protocol GetCandleChart {
    typealias Result = Swift.Result<CandleChartModel, CedroError>
    func get(withBody body: GetCandleChartModel, completion: @escaping (Result) -> Void)
}

public struct GetCandleChartModel: CedroModel {
    public var token: String
    public var module: Module = .chart
    public var service: Service = .candleChart
    public var parameters: GetCandleChartParameters
    
    public init(token: String, quote: String, period: ChartPeriodModel, realTime: Bool, dispatch: DispatchType, quantity: Int? = 2, initDate: Date? = nil) {
        self.token = token
        self.parameters = GetCandleChartParameters(quote: quote, period: period, realTime: realTime, dispatch: dispatch, quantity: quantity, initDate: initDate)
    }
}

public struct GetCandleChartParameters: CedroModel {
    public var quote: String
    public var period: ChartPeriodModel
    public var realTime: String
    public var quantity: String?
    public var dispatch: DispatchType
    public var initDate: String?
    
    public init(quote: String, period: ChartPeriodModel, realTime: Bool, dispatch: DispatchType, quantity: Int? = 2, initDate: Date? = nil) {
        self.quote = quote
        self.period = period
        self.realTime = "\(realTime)"
        self.quantity = "null"
        if let quantity = quantity { self.quantity = "\(quantity)" }
        self.dispatch = dispatch
        self.initDate = "null"
        if let initDate = initDate { self.initDate = initDate.asString(withDateFormat: "yyyyMMdd") }
    }
}

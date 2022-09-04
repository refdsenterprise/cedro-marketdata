import Foundation

protocol GetAggregatedBook {
    typealias Result = Swift.Result<AggregatedBookModel, AggregatedBookError>
    func get(getAggregatedBookModel: GetAggregatedBookModel, completion: @escaping (Result) -> Void)
}

public struct GetAggregatedBookModel: CedroStreamingWebSocketModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .aggregatedBook
    public var parameterGet: String
    public var parameters: GetAggregatedBookParameters
    
    public init(token: String, module: Module = .quotes, service: Service = .aggregatedBook, parameterGet: String, parameters: GetAggregatedBookParameters) {
        self.token = token
        self.module = module
        self.service = service
        self.parameterGet = parameterGet
        self.parameters = parameters
    }
}

public struct GetAggregatedBookParameters: CedroStreamingWebSocketModel {
    public var subsbribetype: SubscribeType
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, delay: String = "") {
        self.subsbribetype = subsbribetype
        self.delay = delay
    }
}

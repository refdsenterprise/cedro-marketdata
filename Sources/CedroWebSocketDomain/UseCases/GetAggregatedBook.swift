import Foundation

public protocol GetAggregatedBook {
    typealias Result = Swift.Result<AggregatedBookModel, CedroError>
    func get(withBody body: GetAggregatedBookModel, completion: @escaping (Result) -> Void)
}

public struct GetAggregatedBookModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .aggregatedBook
    public var parameterGet: String
    public var parameters: GetAggregatedBookParameters
    
    public init(token: String, parameterGet: String, parameters: GetAggregatedBookParameters) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = parameters
    }
}

public struct GetAggregatedBookParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        if let delay = delay { self.delay = "\(delay)" }
    }
}

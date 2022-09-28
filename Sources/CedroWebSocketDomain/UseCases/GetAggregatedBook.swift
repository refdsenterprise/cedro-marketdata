import Foundation
import RefdsDomain

public protocol GetAggregatedBook {
    typealias Result = Swift.Result<AggregatedBookModel, DomainError>
    func get(getAggregatedBookModel: GetAggregatedBookModel, completion: @escaping (Result) -> Void)
}

public struct GetAggregatedBookModel: DomainModel {
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

public struct GetAggregatedBookParameters: DomainModel {
    public var subsbribetype: SubscribeType
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, delay: String = "") {
        self.subsbribetype = subsbribetype
        self.delay = delay
    }
}

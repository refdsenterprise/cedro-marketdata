import Foundation

public protocol GetDetailedBook {
    typealias Result = Swift.Result<DetailedBookModel, CedroError>
    func get(withBody body: GetDetailedBookModel, completion: @escaping (Result) -> Void)
}

public struct GetDetailedBookModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .detailedBook
    public var parameterGet: String
    public var parameters: GetDetailedBookParameters
    
    public init(token: String, parameterGet: String, parameters: GetDetailedBookParameters) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = parameters
    }
}

public struct GetDetailedBookParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var filter: String
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, filter: Int = 15, delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        self.filter = "\(filter)"
        if let delay = delay { self.delay = "\(delay)" }
    }
}

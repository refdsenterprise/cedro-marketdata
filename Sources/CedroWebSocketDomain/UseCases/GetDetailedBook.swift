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
    
    public init(token: String, parameterGet: String, subsbribetype: SubscribeType, amount: Int = 100, delay: Int? = nil) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = GetDetailedBookParameters(subsbribetype: subsbribetype, amount: amount, delay: delay)
    }
}

public struct GetDetailedBookParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var filter: String
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, amount: Int = 100, delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        self.filter = "\(amount)"
        if let delay = delay { self.delay = "\(delay)" }
    }
}

import Foundation

public protocol GetBusinessBook {
    typealias Result = Swift.Result<BusinessBookModel, CedroError>
    func get(withBody body: GetBusinessBookModel, completion: @escaping (Result) -> Void)
}

public struct GetBusinessBookModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .businessBook
    public var parameterGet: String
    public var parameters: GetBusinessBookParameters
    
    public init(token: String, parameterGet: String, subsbribetype: SubscribeType, amount: Int = 100, delay: Int? = nil) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = GetBusinessBookParameters(subsbribetype: subsbribetype, amount: amount, delay: delay)
    }
}

public struct GetBusinessBookParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var quantidade: String
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, amount: Int = 100, delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        self.quantidade = "\(amount)"
        if let delay = delay { self.delay = "\(delay)" }
    }
}

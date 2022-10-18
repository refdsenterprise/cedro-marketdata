import Foundation

public protocol GetQuote {
    typealias Result = Swift.Result<(QuoteModel), CedroError>
    func get(withBody body: GetQuoteModel, completion: @escaping (Result) -> Void)
}

public struct GetQuoteModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .quote
    public var parameterGet: String
    public var parameters: GetQuoteParameters
    
    public init(token: String, parameterGet: String, subsbribetype: SubscribeType, fields: [QuoteValuesModel.CodingKeys] = QuoteValuesModel.CodingKeys.allCases, delay: Int? = nil) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = GetQuoteParameters(subsbribetype: subsbribetype, fields: fields, delay: delay)
    }
}

public struct GetQuoteParameters: CedroModel {
    public var subsbribetype: SubscribeType
    public var filter: String
    public var delay: String = ""
    
    public init(subsbribetype: SubscribeType, fields: [QuoteValuesModel.CodingKeys] = QuoteValuesModel.CodingKeys.allCases, delay: Int? = nil) {
        self.subsbribetype = subsbribetype
        self.filter = "\(fields.map({ $0.rawValue }).joined(separator: ","))"
        if let delay = delay { self.delay = "\(delay)" }
    }
}

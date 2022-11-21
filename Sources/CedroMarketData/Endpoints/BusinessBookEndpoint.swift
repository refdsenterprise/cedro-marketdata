import Foundation
import CedroMarketDataData
import CedroAuthentication

public struct BusinessBookEndpoint: CedroMarketDataEndpoint {
    public var scheme: CedroMarketDataScheme
    public var host: String
    public var path: String
    public var queryItems: [URLQueryItem]?
    public var headers: [CedroHttpHeader]?
    public var body: Data?
    
    public init(token: String) throws {
        guard let stringUrl = CedroAuthentication.shared.environment.model?.webfeeder?.urlWebFeederFacade,
              let urlComponents = URLComponents(string: stringUrl),
              let scheme = urlComponents.scheme,
              let host = urlComponents.host,
              let cedroHttpScheme = CedroMarketDataScheme(rawValue: scheme) else { throw CedroMarketDataError.invalidUrl }
        self.scheme = cedroHttpScheme
        self.host = host
        self.path = urlComponents.path
        self.queryItems = [URLQueryItem(name: "reconnect", value: token)]
    }
}

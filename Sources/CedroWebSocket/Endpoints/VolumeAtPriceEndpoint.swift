import Foundation
import CedroWebSocketData
import CedroAuthentication

public struct VolumeAtPriceEndpoint: CedroWebSocketEndpoint {
    public var scheme: CedroWebSocketScheme
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
              let cedroHttpScheme = CedroWebSocketScheme(rawValue: scheme) else { throw CedroWebSocketError.invalidUrl }
        self.scheme = cedroHttpScheme
        self.host = host
        self.path = urlComponents.path
        self.queryItems = [URLQueryItem(name: "reconnect", value: token)]
    }
}

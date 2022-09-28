import Foundation
import RefdsData

public struct AggregatedBookWebSocketEndpoint: WebSocketEndpoint {
    public var scheme: RefdsData.WebSocketScheme = WebSocketScheme(rawValue: Environment.variable(.scheme))!
    public var host: String = Environment.variable(.host)
    public var path: String = "/ws"
    public var queryItems: [URLQueryItem]?
    
    public init(queryItems: [URLQueryItem]) {
        self.queryItems = queryItems
    }
}

import Foundation
import RefdsData

public struct LoginWebSocketEndoint: WebSocketEndpoint {
    public var scheme: RefdsData.WebSocketScheme = WebSocketScheme(rawValue: Environment.variable(.scheme))!
    public var host: String = Environment.variable(.host)
    public var path: String = "/ws"
}

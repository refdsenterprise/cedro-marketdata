import Foundation

public enum LoginError: CedroStreamingWebSocketError {
    case genericError
    case decodedError
    case websocketError(WebSocketError)
}

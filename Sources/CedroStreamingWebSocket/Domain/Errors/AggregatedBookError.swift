import Foundation

public enum AggregatedBookError: CedroStreamingWebSocketError {
    case genericError
    case decodedError
    case websocketError(WebSocketError)
}

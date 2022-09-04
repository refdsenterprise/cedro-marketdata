import Foundation

public enum WebSocketError: CedroStreamingWebSocketError {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}

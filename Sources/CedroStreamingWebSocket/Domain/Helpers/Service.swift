import Foundation

public enum Service: String, CedroStreamingWebSocketModel {
    case authentication = "authentication"
    case aggregatedBook = "aggregatedBook"
}

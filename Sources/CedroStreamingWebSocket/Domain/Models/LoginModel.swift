import Foundation

public struct LoginModel: CedroStreamingWebSocketModel {
    public let success: Bool
    public let token: String
}

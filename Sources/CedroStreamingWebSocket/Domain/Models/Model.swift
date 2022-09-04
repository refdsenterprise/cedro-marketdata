import Foundation

protocol CedroStreamingWebSocketModel: Codable {}

extension CedroStreamingWebSocketModel {
    var stringValue: String? {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(self) else { return nil }
        return String(data: encoded, encoding: .utf8)
    }
}

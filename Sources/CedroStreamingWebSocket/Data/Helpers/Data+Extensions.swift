import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        guard let decoded = try? JSONDecoder().decode(T.self, from: self) else { return nil }
        return decoded
    }
}

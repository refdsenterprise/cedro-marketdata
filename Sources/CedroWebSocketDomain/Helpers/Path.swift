import Foundation

public enum Path: String {
    case ws = "ws"
    
    func withReconnect(token: String) -> RawValue {
        return self.rawValue + "?reconnect=\(token)"
    }
}

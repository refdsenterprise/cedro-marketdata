import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case scheme = "wss"
        case host = "webfeeder.cedrotech.com"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return key.rawValue
    }
}

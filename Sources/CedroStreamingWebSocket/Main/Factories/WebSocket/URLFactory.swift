import Foundation

func makeURL(withPath path: Path = .ws, token: String = "", hasReconnect: Bool = false) -> URL {
    return URL(string: "wss://webfeeder.cedrotech.com/\(hasReconnect ? path.withReconnect(token: token) : path.rawValue)")!
}

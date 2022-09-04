import Foundation

func makeURL(withPath path: Path) -> URL {
    return URL(string: "wss://webfeeder.cedrotech.com/\(path.rawValue)")!
}

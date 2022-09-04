import Foundation

protocol WebSocketClient {
    typealias Result = Swift.Result<Data, WebSocketError>
    var isOpenConnection: Bool { get }
    func websocket(to url: URL, completion: @escaping (Result) -> Void) -> Self
    func subscribe(with encodable: CedroStreamingWebSocketModel)
}

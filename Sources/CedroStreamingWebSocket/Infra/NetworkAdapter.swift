import Foundation

final class NetworkAdapter: NSObject, WebSocketClient {
    private var session: URLSession
    private var webSocket: URLSessionWebSocketTask?
    private var completion: ((WebSocketClient.Result) -> Void)?
    private let receivedSemaphore = DispatchSemaphore(value: 1)
    private let openConnectionSemaphore = DispatchSemaphore(value: 1)
    private var _isOpenConnection = false
    var isOpenConnection: Bool { return _isOpenConnection }
    
    private let receivedQueue = DispatchQueue(
        label: "cedro.streaming.websocket.network.received",
        qos: .userInitiated,
        attributes: .concurrent
    )
    
    private let subscribeQueue = DispatchQueue(
        label: "cedro.streaming.websocket.network.subscribe",
        qos: .userInitiated,
        attributes: .concurrent
    )
    
    override init() {
        session = .shared
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }
    
    func websocket(to url: URL, completion: @escaping (WebSocketClient.Result) -> Void) -> Self {
        self.completion = completion
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        openConnectionSemaphore.wait()
        return self
    }
    
    func subscribe(with encodable: CedroStreamingWebSocketModel) {
        openConnectionSemaphore.wait()
        subscribeQueue.async { [weak self] in
            guard let self = self else { return }
            guard let string = encodable.stringValue else { return self.completion?(.failure(.badRequest)) ?? () }
            self.webSocket?.send(.string(string), completionHandler: { [weak self] error in
                self?.completion?(.failure(.serverError))
            })
        }
        openConnectionSemaphore.signal()
    }
    
    private func received() {
        webSocket?.receive(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.receivedQueue.async { [weak self] in
                guard let self = self else { return }
                self.receivedSemaphore.wait()
                switch result {
                case .success(let message):
                    switch message {
                    case .string(let string):
                        if let data = string.data(using: .utf8) { self.completion?(.success(data)) }
                        else { self.completion?(.failure(.badRequest)) }
                    default: self.completion?(.failure(.forbidden))
                    }
                case .failure(_): self.completion?(.failure(.serverError))
                }
                self.receivedSemaphore.signal()
            }
        })
    }
}

// MARK: - URL Session WebSocket
extension NetworkAdapter: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        _isOpenConnection = true
        received()
        openConnectionSemaphore.signal()
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        _isOpenConnection = false
    }
}

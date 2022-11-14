import Foundation
import CedroWebSocketDomain

public final class RemoteGetBusinessBook: GetBusinessBook, CedroWebSocketRequest {
    public typealias Response = BusinessBookModel
    public var webSocketClient: CedroWebSocketClient
    public var webSocketEndpoint: CedroWebSocketEndpoint
    private var webSocketStatus: CedroWebSocketStatus = .close
    
    public init(webSocketEndpoint: CedroWebSocketEndpoint, webSocketClient: CedroWebSocketClient) {
        self.webSocketEndpoint = webSocketEndpoint
        self.webSocketClient = webSocketClient
    }
    
    public func get(withBody body: GetBusinessBookModel, completion: @escaping (GetBusinessBook.Result) -> Void) {
        webSocketClient.status = { [weak self] status in
            self?.webSocketStatus = status
        }
        
        webSocketClient.error = { error in
            completion(.failure(.requestError(error: error)))
        }
        
        webSocketClient.success = { [weak self] data in
            if let decoded = try? self?.decode(data) { completion(.success(decoded)) }
            else { self?.webSocketClient.error?(.invalidResponse(content: data)) }
        }
        
        switch webSocketStatus {
        case .open: webSocketClient.send(with: body)
        case .close: webSocketClient.webSocket(request: self).send(with: body)
        }
    }
    
    public func decode(_ data: Data) throws -> Response {
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss a"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let decoded: Response = try? jsonDecoder.decode(Response.self, from: data) else { throw CedroWebSocketError.invalidResponse(content: data) }
        return decoded
    }
}

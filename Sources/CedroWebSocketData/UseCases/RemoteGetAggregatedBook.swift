import Foundation
import CedroWebSocketDomain
import RefdsData

public final class RemoteGetAggregatedBook: GetAggregatedBook, WebSocketRequest {
    public typealias Response = AggregatedBookModel
    public var webSocketClient: WebSocketClient
    public var webSocketEndpoint: WebSocketEndpoint
    private var webSocketStatus: WebSocketStatus = .close
    
    public init(webSocketEndpoint: WebSocketEndpoint, webSocketClient: WebSocketClient) {
        self.webSocketEndpoint = webSocketEndpoint
        self.webSocketClient = webSocketClient
    }
    
    public func get(getAggregatedBookModel: GetAggregatedBookModel, completion: @escaping (GetAggregatedBook.Result) -> Void) {
        webSocketClient.status = { [weak self] status in
            self?.webSocketStatus = status
        }
        
        webSocketClient.error = { error in
            completion(.failure(.requestError(error: error)))
        }
        
        webSocketClient.success = { [weak self] data in
            if let aggregatedBookModel: AggregatedBookModel = data.asModel() { completion(.success(aggregatedBookModel)) }
            else { self?.webSocketClient.error?(.invalidResponse(content: data)) }
        }
        
        switch webSocketStatus {
        case .open: webSocketClient.send(with: getAggregatedBookModel)
        case .close: webSocketClient.webSocket(request: self).send(with: getAggregatedBookModel)
        }
    }
}

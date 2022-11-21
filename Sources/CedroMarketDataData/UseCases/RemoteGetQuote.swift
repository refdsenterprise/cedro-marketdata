import Foundation
import CedroMarketDataDomain

public final class RemoteGetQuote: GetQuote, CedroMarketDataRequest {
    public typealias Response = QuoteModel
    public var webSocketClient: CedroMarketDataClient
    public var webSocketEndpoint: CedroMarketDataEndpoint
    private var webSocketStatus: CedroMarketDataStatus = .close
    
    public init(webSocketEndpoint: CedroMarketDataEndpoint, webSocketClient: CedroMarketDataClient) {
        self.webSocketEndpoint = webSocketEndpoint
        self.webSocketClient = webSocketClient
    }
    
    public func get(withBody body: GetQuoteModel, completion: @escaping (GetQuote.Result) -> Void) {
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
}

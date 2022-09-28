import Foundation
import CedroWebSocketDomain
import RefdsData

public final class RemoteAddLogin: AddLogin, WebSocketRequest {
    public typealias Response = LoginModel
    public var webSocketClient: WebSocketClient
    public var webSocketEndpoint: WebSocketEndpoint
    private var webSocketStatus: WebSocketStatus = .close
    
    public init(webSocketEndpoint: WebSocketEndpoint, webSocketClient: WebSocketClient) {
        self.webSocketEndpoint = webSocketEndpoint
        self.webSocketClient = webSocketClient
    }
    
    public func add(addLoginModel: AddLoginModel, completion: @escaping (AddLogin.Result) -> Void) {
        webSocketClient.status = { [weak self] status in
            self?.webSocketStatus = status
        }
        
        webSocketClient.error = { error in
            completion(.failure(.requestError(error: error)))
        }
        
        webSocketClient.success = { [weak self] data in
            if let loginModel: LoginModel = data.asModel() { completion(.success(loginModel)) }
            else { self?.webSocketClient.error?(.invalidResponse(content: data)) }
        }
        
        switch webSocketStatus {
        case .open: webSocketClient.send(with: addLoginModel)
        case .close: webSocketClient.webSocket(request: self).send(with: addLoginModel)
        }
    }
}

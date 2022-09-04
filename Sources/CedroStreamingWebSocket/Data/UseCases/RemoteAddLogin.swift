import Foundation

final class RemoteAddLogin: AddLogin {
    private let url: URL
    private let webSocketClient: WebSocketClient
    
    init(url: URL, webSocketClient: WebSocketClient) {
        self.url = url
        self.webSocketClient = webSocketClient
    }
    
    func add(addLoginModel: AddLoginModel, completion: @escaping (AddLogin.Result) -> Void) {
        if webSocketClient.isOpenConnection {
            webSocketClient.subscribe(with: addLoginModel)
        } else {
            webSocketClient.websocket(to: url) { result in
                switch result {
                case .success(let data):
                    if let loginModel: LoginModel = data.toModel() { completion(.success(loginModel)) }
                    else { completion(.failure(.decodedError)) }
                    
                case .failure(let error):
                    completion(.failure(.websocketError(error)))
                }
            }.subscribe(with: addLoginModel)
        }
    }
}

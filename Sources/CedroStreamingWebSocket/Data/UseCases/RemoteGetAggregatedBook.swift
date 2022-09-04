import Foundation

final class RemoteGetAggregatedBook: GetAggregatedBook {
    private let url: URL
    private let webSocketClient: WebSocketClient
    
    init(url: URL, webSocketClient: WebSocketClient) {
        self.url = url
        self.webSocketClient = webSocketClient
    }
    
    func get(getAggregatedBookModel: GetAggregatedBookModel, completion: @escaping (GetAggregatedBook.Result) -> Void) {
        if webSocketClient.isOpenConnection {
            webSocketClient.subscribe(with: getAggregatedBookModel)
        } else {
            webSocketClient.websocket(to: url) { result in
                switch result {
                case .success(let data):
                    if let aggregatedBook: AggregatedBookModel = data.toModel() { completion(.success(aggregatedBook)) }
                    else { completion(.failure(.decodedError)) }
                case .failure(let error): completion(.failure(.websocketError(error)))
                }
            }.subscribe(with: getAggregatedBookModel)
        }
    }
}

import Foundation
import CedroWebSocketPresentation
import CedroWebSocketDomain
import CedroAuthentication

final class DetailedBookController {
    static var instance: Self { Self() }
    private var response: ((GetDetailedBook.Result) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    
    private lazy var presenter = { try? makeDetailedBookPresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
    init() {
        semaphore.wait()
        Task {
            let result = await CedroAuthentication.shared.getLoginWebSocket()
            switch result {
            case .success(let loginWebSocket): tokenWebSocket = loginWebSocket.tokenWS
            case .failure(let error): response?(.failure(error))
            }
            semaphore.signal()
        }
    }
    
    deinit { unsubscribe() }
    
    func subscribe(_ symbol: String, response: ((GetDetailedBook.Result) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.detailedBook(
            withBody: GetDetailedBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                parameters: GetDetailedBookParameters(subsbribetype: .start)))
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        presenter?.detailedBook(
            withBody: GetDetailedBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                parameters: GetDetailedBookParameters(subsbribetype: .end)))
        semaphore.signal()
    }
}

extension DetailedBookController: DetailedBookPresenterDelegate {
    func detailedBook(didReceive detailedBookModel: DetailedBookModel) {
        response?(.success(detailedBookModel))
    }
    
    func detailedBook(didReceive error: CedroError) { }
}

import Foundation
import CedroWebSocketPresentation
import CedroWebSocketDomain
import CedroAuthentication

final class BusinessBookController {
    static var instance: Self { Self() }
    private var response: ((GetBusinessBook.Result) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    
    private lazy var presenter = { try? makeBusinessBookPresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
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
    
    deinit {
        unsubscribe()
        presenter = nil
    }
    
    func subscribe(_ symbol: String, response: ((GetBusinessBook.Result) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.businessBook(
            withBody: GetBusinessBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .start))
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        presenter?.businessBook(
            withBody: GetBusinessBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .end))
        semaphore.signal()
    }
}

// MARK: BusinessBookPresenterDelegate
extension BusinessBookController: BusinessBookPresenterDelegate {
    func businessBook(didReceive businessBookModel: BusinessBookModel) {
        response?(.success(businessBookModel))
    }
    
    func businessBook(didReceive error: CedroError) { }
}

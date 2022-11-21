import Foundation
import CedroMarketDataPresentation
import CedroMarketDataDomain
import CedroAuthentication

final class AggregatedBookController {
    static var instance: Self { Self() }
    private var response: ((GetAggregatedBook.Result) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    
    private lazy var presenter = { try? makeAggregatedBookPresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
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
    
    func subscribe(_ symbol: String, response: ((GetAggregatedBook.Result) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.aggregatedBook(
            withBody: GetAggregatedBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .start))
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        presenter?.aggregatedBook(
            withBody: GetAggregatedBookModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                subsbribetype: .end))
        semaphore.signal()
    }
}

extension AggregatedBookController: AggregatedBookPresenterDelegate {
    func aggregatedBook(didReceive aggregatedBookModel: AggregatedBookModel) {
        response?(.success(aggregatedBookModel))
    }
    
    func aggregatedBook(didReceive error: CedroError) { }
}

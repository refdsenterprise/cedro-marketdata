import Foundation
import CedroWebSocketPresentation
import CedroWebSocketDomain
import CedroAuthentication

final class VolumeAtPriceController {
    static var instance: Self { Self() }
    private var response: ((GetVolumeAtPrice.Result) -> Void)?
    private var semaphore = DispatchSemaphore(value: 1)
    private var tokenWebSocket: String = ""
    private var currentSymbol: String = ""
    
    private lazy var presenter = { try? makeVolumeAtPricePresenter(delegate: WeakProxy(self), token: tokenWebSocket) }()
    
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
    
    func subscribe(_ symbol: String, response: ((GetVolumeAtPrice.Result) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.volumeAtPrice(
            withBody: GetVolumeAtPriceModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                parameters: GetVolumeAtPriceParameters(dispatch: .start)))
        semaphore.signal()
    }
    
    public func unsubscribe() {
        semaphore.wait()
        presenter?.volumeAtPrice(
            withBody: GetVolumeAtPriceModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                parameters: GetVolumeAtPriceParameters(dispatch: .end)))
        semaphore.signal()
    }
}

// MARK: VolumeAtPricePresenterDelegate
extension VolumeAtPriceController: VolumeAtPricePresenterDelegate {
    func volumeAtPrice(didReceive volumeAtPriceModel: VolumeAtPriceModel) {
        response?(.success(volumeAtPriceModel))
    }
    
    func volumeAtPrice(didReceive error: CedroError) { }
}

import Foundation
import CedroMarketDataPresentation
import CedroMarketDataDomain
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
    
    deinit {
        unsubscribe()
        presenter = nil
    }
    
    func subscribe(_ symbol: String, response: ((GetVolumeAtPrice.Result) -> Void)? = nil, manager: ((VolumeAtPriceManager) -> Void)? = nil) {
        self.response = response
        self.currentSymbol = symbol
        semaphore.wait()
        presenter?.manager.observer = { [weak self] in
            if let presenterManager = self?.presenter?.manager { manager?(presenterManager) }
        }
        presenter?.volumeAtPrice(
            withBody: GetVolumeAtPriceModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                dispatch: .start))
        semaphore.signal()
    }
    
    func unsubscribe() {
        semaphore.wait()
        presenter?.volumeAtPrice(
            withBody: GetVolumeAtPriceModel(
                token: tokenWebSocket,
                parameterGet: currentSymbol,
                dispatch: .end))
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

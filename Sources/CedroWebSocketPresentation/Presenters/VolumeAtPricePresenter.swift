import Foundation
import CedroWebSocketDomain

public protocol VolumeAtPricePresenterDelegate {
    func volumeAtPrice(didReceive volumeAtPriceModel: VolumeAtPriceModel)
    func volumeAtPrice(didReceive error: CedroError)
}

public final class VolumeAtPricePresenter {
    private let useCase: GetVolumeAtPrice
    private let delegate: VolumeAtPricePresenterDelegate
    public let manager: VolumeAtPriceManager = .instance
    private let updateControl = DispatchSemaphore(value: 1)
    
    private let managerQueue = DispatchQueue(
        label: "cedro.websocket.volumeAtPrice.presenter.manager",
        qos: .unspecified
    )
    
    public init(useCase: GetVolumeAtPrice, delegate: VolumeAtPricePresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func volumeAtPrice(withBody body: GetVolumeAtPriceModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.manager._response = model
                self.managerQueue.async { [weak self] in
                    self?.updateControl.wait()
                    self?.manager.update(withNewValue: model)
                    self?.updateControl.signal()
                }
                self.delegate.volumeAtPrice(didReceive: model)
            case .failure(let error):
                self.delegate.volumeAtPrice(didReceive: error)
            }
        }
    }
}

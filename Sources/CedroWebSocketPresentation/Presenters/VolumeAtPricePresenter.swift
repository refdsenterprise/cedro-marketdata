import Foundation
import CedroWebSocketDomain

public protocol VolumeAtPricePresenterDelegate {
    func volumeAtPrice(didReceive volumeAtPriceModel: VolumeAtPriceModel)
    func volumeAtPrice(didReceive error: CedroError)
}

public final class VolumeAtPricePresenter {
    private let useCase: GetVolumeAtPrice
    private let delegate: VolumeAtPricePresenterDelegate
    public private(set) var volumeAtPriceResponse: VolumeAtPriceModel?
    
    public init(useCase: GetVolumeAtPrice, delegate: VolumeAtPricePresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func volumeAtPrice(withBody body: GetVolumeAtPriceModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.volumeAtPriceResponse = model
                self.delegate.volumeAtPrice(didReceive: model)
            case .failure(let error):
                self.delegate.volumeAtPrice(didReceive: error)
            }
        }
    }
}

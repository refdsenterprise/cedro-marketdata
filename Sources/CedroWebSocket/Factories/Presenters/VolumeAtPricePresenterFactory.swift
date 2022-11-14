import Foundation
import CedroWebSocketPresentation

func makeVolumeAtPricePresenter(delegate: VolumeAtPricePresenterDelegate, token: String) throws -> VolumeAtPricePresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getVolumeAtPrice = try makeRemoteGetVolumeAtPrice(withCedroWebSocketClient: websocketClient, token: token)
    return VolumeAtPricePresenter(useCase: getVolumeAtPrice, delegate: delegate)
}

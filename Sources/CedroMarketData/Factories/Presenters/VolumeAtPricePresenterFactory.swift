import Foundation
import CedroMarketDataPresentation

func makeVolumeAtPricePresenter(delegate: VolumeAtPricePresenterDelegate, token: String) throws -> VolumeAtPricePresenter {
    let websocketClient = makeWebSocketNetworkAdapter()
    let getVolumeAtPrice = try makeRemoteGetVolumeAtPrice(withCedroMarketDataClient: websocketClient, token: token)
    return VolumeAtPricePresenter(useCase: getVolumeAtPrice, delegate: delegate)
}

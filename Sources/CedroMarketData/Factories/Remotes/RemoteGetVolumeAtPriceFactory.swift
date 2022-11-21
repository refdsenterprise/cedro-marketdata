import Foundation
import CedroMarketDataDomain
import CedroMarketDataData

func makeRemoteGetVolumeAtPrice(withCedroMarketDataClient webSocketClient: CedroMarketDataClient, token: String) throws -> GetVolumeAtPrice {
    let remoteGetVolumeAtPrice = RemoteGetVolumeAtPrice(webSocketEndpoint: try VolumeAtPriceEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetVolumeAtPrice)
}

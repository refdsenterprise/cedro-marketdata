import Foundation
import CedroWebSocketDomain
import CedroWebSocketData

func makeRemoteGetVolumeAtPrice(withCedroWebSocketClient webSocketClient: CedroWebSocketClient, token: String) throws -> GetVolumeAtPrice {
    let remoteGetVolumeAtPrice = RemoteGetVolumeAtPrice(webSocketEndpoint: try VolumeAtPriceEndpoint(token: token), webSocketClient: webSocketClient)
    return DispatchMainQueueDecorator(remoteGetVolumeAtPrice)
}

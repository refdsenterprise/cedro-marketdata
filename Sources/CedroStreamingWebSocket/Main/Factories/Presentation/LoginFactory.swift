import Foundation

public func makeLogin(delegate: LoginDelegate) -> Login {
    let websocketClient = makeNetworkAdapter()
    let addLogin = makeRemoteAddLogin(withWebSocketClient: websocketClient)
    return Login(addLogin: addLogin, delegate: delegate)
}

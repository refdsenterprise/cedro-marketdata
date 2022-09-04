import XCTest
import CedroStreamingWebSocket

final class CedroStreamingWebSocketTests: XCTestCase {
    let expectation = XCTestExpectation()
    func test() throws {
        let login = makeLogin(delegate: self)
        login.login(withCredentials: AddLoginModel(module: .login, service: .authentication, parameters: AddLoginParametersModel(login: "fasttrade", password: "102030")))
        wait(for: [expectation], timeout: 5000)
    }
}

extension CedroStreamingWebSocketTests: LoginDelegate {
    func login(didReceived loginModel: LoginModel) {
        print(loginModel)
    }
}

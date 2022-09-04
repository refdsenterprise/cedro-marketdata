import XCTest
import CedroStreamingWebSocket

final class CedroStreamingWebSocketTests: XCTestCase {
    let loginExpectation = XCTestExpectation()
    
    lazy var login: Login = {
        return makeLogin(delegate: self)
    }()
    
    func testLogin() throws {
        login.login(withCredentials: AddLoginModel(module: .login, service: .authentication, parameters: AddLoginParametersModel(login: "fasttrade", password: "102030")))
        wait(for: [loginExpectation], timeout: 10)
    }
}

extension CedroStreamingWebSocketTests: LoginDelegate {
    func login(didReceived loginModel: LoginModel) {
        XCTAssert(loginModel.success)
        XCTAssert(loginModel.token.isEmpty == false)
        loginExpectation.fulfill()
    }
}

import XCTest
import CedroStreamingWebSocket

final class CedroStreamingWebSocketTests: XCTestCase {
    let expectations = [XCTestExpectation(), XCTestExpectation()]
    
    lazy var login: Login = {
        return makeLogin(delegate: self)
    }()
    
    lazy var aggregatedBook: AggregatedBook = {
        return makeAggregatedBook(token: "507e2861-9b75-417d-9851-8871c8a15aa8", delegate: self)
    }()
    
    func testLogin() throws {
        login.login(
            withRequestModel: AddLoginModel(
                parameters: AddLoginParametersModel(
                    login: "fasttrade",
                    password: "102030"
                )
            )
        )
        wait(for: [expectations[0]], timeout: 10)
    }
    
    func testAggregatedBook() {
        aggregatedBook.aggregatedBook(
            withRequestModel: GetAggregatedBookModel(
                token: "507e2861-9b75-417d-9851-8871c8a15aa8",
                parameterGet: "petr4",
                parameters: GetAggregatedBookParameters(subsbribetype: .start)
            )
        )
        wait(for: [expectations[1]], timeout: 10)
    }
}

extension CedroStreamingWebSocketTests: LoginDelegate {
    func login(didReceived loginModel: LoginModel) {
        XCTAssert(loginModel.success)
        XCTAssertFalse(loginModel.token.isEmpty)
        expectations[0].fulfill()
    }
}

extension CedroStreamingWebSocketTests: AggregatedBookDelegate {
    func aggregatedBook(didReceived aggregatedBookModel: AggregatedBookModel) {
        XCTAssertEqual(aggregatedBookModel.type, .aggregatedBookType)
        XCTAssertEqual(aggregatedBookModel.parameter, "petr4")
        expectations[1].fulfill()
    }
}

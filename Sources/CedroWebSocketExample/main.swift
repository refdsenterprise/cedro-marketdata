import Foundation
import CedroWebSocket
import CedroWebSocketDomain
import CedroWebSocketData
import CedroWebSocketPresentation

CedroWebSocketExample.shared.run()
RunLoop.current.run()

class CedroWebSocketExample {
    static let shared = CedroWebSocketExample()
    private var token: String = ""
    private lazy var login: Login = { return makeLogin(delegate: WeakProxy(self)) }()
    private lazy var aggregatedBook: AggregatedBook = { return makeAggregatedBook(token: token, delegate: WeakProxy(self)) }()
    
    func run() {
        addLogin()
    }
    
    private func addLogin() {
        login.login(
            withRequestModel: AddLoginModel(
                parameters: AddLoginParametersModel(
                    login: "fasttrade",
                    password: "102030"
                )
            )
        )
    }
    
    private func getAggregatedBook(token: String) {
        aggregatedBook.aggregatedBook(
            withRequestModel: GetAggregatedBookModel(
                token: token,
                parameterGet: "petr4",
                parameters: GetAggregatedBookParameters(subsbribetype: .start)
            )
        )
    }
}

extension CedroWebSocketExample: LoginDelegate {
    func login(didReceive loginModel: LoginModel) {
        loginModel.logger.console()
        token = loginModel.token
        getAggregatedBook(token: loginModel.token)
    }
}

extension CedroWebSocketExample: AggregatedBookDelegate {
    func aggregatedBook(didReceive aggregatedBookModel: AggregatedBookModel) {
        aggregatedBookModel.logger.console()
    }
}

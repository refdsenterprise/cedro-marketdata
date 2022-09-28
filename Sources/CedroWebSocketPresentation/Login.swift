import Foundation
import RefdsDomain
import CedroWebSocketDomain

public protocol LoginDelegate {
    func login(didReceive loginModel: LoginModel)
    func login(didReceive error: DomainError)
}

public extension LoginDelegate {
    func login(didReceive error: DomainError) {}
}

public final class Login {
    private let useCase: AddLogin
    private let delegate: LoginDelegate
    public private(set) var loginResponse: LoginModel?
    
    public init(useCase: AddLogin, delegate: LoginDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func login(withRequestModel credentials: AddLoginModel) {
        useCase.add(addLoginModel: credentials) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.loginResponse = model
                self.delegate.login(didReceive: model)
            case .failure(let error):
                self.delegate.login(didReceive: error)
            }
        }
    }
}

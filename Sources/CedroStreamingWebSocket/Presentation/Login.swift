import Foundation

public protocol LoginDelegate {
    func login(didReceived loginModel: LoginModel)
    func login(didReceived error: LoginError)
}

public extension LoginDelegate {
    func login(didReceived error: LoginError) {}
}

public final class Login {
    private let useCase: AddLogin
    private let delegate: LoginDelegate
    public private(set) var loginResponse: LoginModel?
    
    init(useCase: AddLogin, delegate: LoginDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func login(withRequestModel credentials: AddLoginModel) {
        useCase.add(addLoginModel: credentials) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.loginResponse = model
                self.delegate.login(didReceived: model)
            case .failure(let error):
                self.delegate.login(didReceived: error)
            }
        }
    }
}

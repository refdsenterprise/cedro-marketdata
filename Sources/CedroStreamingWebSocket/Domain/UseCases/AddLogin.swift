import Foundation

protocol AddLogin {
    typealias Result = Swift.Result<LoginModel, LoginError>
    func add(addLoginModel: AddLoginModel, completion: @escaping (Result) -> Void)
}

public struct AddLoginModel: CedroStreamingWebSocketModel {
    public var module: Module = .login
    public var service: Service = .authentication
    public var parameters: AddLoginParametersModel
    
    public init(module: Module = .login, service: Service = .authentication, parameters: AddLoginParametersModel) {
        self.module = module
        self.service = service
        self.parameters = parameters
    }
}

public struct AddLoginParametersModel: CedroStreamingWebSocketModel {
    public var login: String
    public var password: String
    
    public init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

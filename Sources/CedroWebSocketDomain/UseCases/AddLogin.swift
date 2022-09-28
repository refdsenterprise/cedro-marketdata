import Foundation
import RefdsDomain

public protocol AddLogin {
    typealias Result = Swift.Result<LoginModel, DomainError>
    func add(addLoginModel: AddLoginModel, completion: @escaping (Result) -> Void)
}

public struct AddLoginModel: DomainModel {
    public var module: Module = .login
    public var service: Service = .authentication
    public var parameters: AddLoginParametersModel
    
    public init(parameters: AddLoginParametersModel) {
        self.parameters = parameters
    }
}

public struct AddLoginParametersModel: DomainModel {
    public var login: String
    public var password: String
    
    public init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

import Foundation
import RefdsDomain

public struct LoginModel: DomainModel {
    public let success: Bool
    public let token: String
}

import Foundation
import CedroWebSocketDomain
import CedroWebSocketPresentation

public class WeakProxy<T: AnyObject> {
    private weak var instance: T?
    
    public init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakProxy: LoginDelegate where T: LoginDelegate {
    public func login(didReceive loginModel: LoginModel) {
        instance?.login(didReceive: loginModel)
    }
}

extension WeakProxy: AggregatedBookDelegate where T: AggregatedBookDelegate {
    public func aggregatedBook(didReceive aggregatedBookModel: CedroWebSocketDomain.AggregatedBookModel) {
        instance?.aggregatedBook(didReceive: aggregatedBookModel)
    }
}

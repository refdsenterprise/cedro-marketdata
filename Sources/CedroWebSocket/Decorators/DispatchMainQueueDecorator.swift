import Foundation
import CedroWebSocketDomain

public final class DispatchMainQueueDecorator<T> {
    private var instance: T

    public init(_ instance: T) {
        self.instance = instance
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

// MARK: - GetAggregatedBook
extension DispatchMainQueueDecorator: GetAggregatedBook where T: GetAggregatedBook {
    public func get(withBody body: GetAggregatedBookModel, completion: @escaping (GetAggregatedBook.Result) -> Void) {
        instance.get(withBody: body) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

// MARK: - GetDetailedBook
extension DispatchMainQueueDecorator: GetDetailedBook where T: GetDetailedBook {
    public func get(withBody body: GetDetailedBookModel, completion: @escaping (GetDetailedBook.Result) -> Void) {
        instance.get(withBody: body) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

// MARK: - GetBusinessBook
extension DispatchMainQueueDecorator: GetBusinessBook where T: GetBusinessBook {
    public func get(withBody body: GetBusinessBookModel, completion: @escaping (GetBusinessBook.Result) -> Void) {
        instance.get(withBody: body) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

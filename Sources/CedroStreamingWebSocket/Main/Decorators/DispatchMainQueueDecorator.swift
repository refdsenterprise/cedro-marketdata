import Foundation

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

extension DispatchMainQueueDecorator: AddLogin where T: AddLogin {
    func add(addLoginModel: AddLoginModel, completion: @escaping (AddLogin.Result) -> Void) {
        instance.add(addLoginModel: addLoginModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension DispatchMainQueueDecorator: GetAggregatedBook where T: GetAggregatedBook {
    func get(getAggregatedBookModel: GetAggregatedBookModel, completion: @escaping (GetAggregatedBook.Result) -> Void) {
        instance.get(getAggregatedBookModel: getAggregatedBookModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

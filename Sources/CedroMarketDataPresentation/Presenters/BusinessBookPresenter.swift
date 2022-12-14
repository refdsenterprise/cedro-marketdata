import Foundation
import CedroMarketDataDomain

public protocol BusinessBookPresenterDelegate {
    func businessBook(didReceive businessBookModel: BusinessBookModel)
    func businessBook(didReceive error: CedroError)
}

public final class BusinessBookPresenter {
    private let useCase: GetBusinessBook
    private let delegate: BusinessBookPresenterDelegate
    public let manager: BusinessBookManager = .instance
    private let updateControl = DispatchSemaphore(value: 1)
    
    private let managerQueue = DispatchQueue(
        label: "cedro.marketData.businessBook.presenter.manager",
        qos: .unspecified
    )
    
    public init(useCase: GetBusinessBook, delegate: BusinessBookPresenterDelegate) {
        self.useCase = useCase
        self.delegate = delegate
    }
    
    public func businessBook(withBody body: GetBusinessBookModel) {
        useCase.get(withBody: body) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.manager._response = model
                self.managerQueue.async { [weak self] in
                    self?.updateControl.wait()
                    self?.manager.update(withNewValue: model)
                    self?.updateControl.signal()
                }
                self.delegate.businessBook(didReceive: model)
            case .failure(let error):
                self.delegate.businessBook(didReceive: error)
            }
        }
    }
}

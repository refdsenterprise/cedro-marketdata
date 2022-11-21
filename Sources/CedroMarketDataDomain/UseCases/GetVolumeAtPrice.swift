import Foundation

public protocol GetVolumeAtPrice {
    typealias Result = Swift.Result<VolumeAtPriceModel, CedroError>
    func get(withBody body: GetVolumeAtPriceModel, completion: @escaping (Result) -> Void)
}

public struct GetVolumeAtPriceModel: CedroModel {
    public var token: String
    public var module: Module = .quotes
    public var service: Service = .volumeAtPrice
    public var parameterGet: String
    public var parameters: GetVolumeAtPriceParameters
    
    public init(token: String, parameterGet: String, dispatch: DispatchType) {
        self.token = token
        self.parameterGet = parameterGet
        self.parameters = GetVolumeAtPriceParameters(dispatch: dispatch)
    }
}

public struct GetVolumeAtPriceParameters: CedroModel {
    public var dispatch: DispatchType
    
    public init(dispatch: DispatchType) {
        self.dispatch = dispatch
    }
}

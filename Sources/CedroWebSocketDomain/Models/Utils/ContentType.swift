import Foundation

public enum ContentType: String, CedroModel {
    case aggregatedBookType = "AggregatedBookType"
    case detailedBookType = "BookSnapshotType"
    case businessBookType = "BusinessBookType"
}

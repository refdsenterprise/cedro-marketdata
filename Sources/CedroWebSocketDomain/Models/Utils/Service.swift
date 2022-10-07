import Foundation

public enum Service: String, CedroModel {
    case authentication = "authentication"
    case aggregatedBook = "aggregatedBook"
    case detailedBook = "book"
    case businessBook = "quoteTrade"
}

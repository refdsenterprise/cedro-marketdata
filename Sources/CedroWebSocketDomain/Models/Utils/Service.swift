import Foundation

public enum Service: String, CedroModel {
    case aggregatedBook = "aggregatedBook"
    case detailedBook = "book"
    case businessBook = "quoteTrade"
    case volumeAtPrice = "volumeAtPrice"
    case quote = "quote"
}

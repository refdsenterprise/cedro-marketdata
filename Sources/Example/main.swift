import Foundation
import CedroWebSocket

func main() {
    CedroWebSocket.shared.start(username: "any-username", password: "any-password")
    
    CedroWebSocket.shared.aggregatedBook("petr4") { aggregatedBook in
        aggregatedBook.logger(additionalMessage: nil).console()
    }
    
    CedroWebSocket.shared.detailedBook("vale3") { detailedBook in
        detailedBook.logger(additionalMessage: nil).console()
    }
}

main()

RunLoop.current.run()

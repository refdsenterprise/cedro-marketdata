import Foundation
import CedroWebSocket

func main() {
    CedroWebSocket.shared.start(username: "fasttrade", password: "102030")
    
    CedroWebSocket.shared.subscribe(on: .aggregatedBook("petr4", response: { aggregatedBook in
        aggregatedBook.logger(additionalMessage: nil).console()
    }))
    
    CedroWebSocket.shared.subscribe(on: .detailedBook("petr4", response: { detailedBook in
        detailedBook.logger(additionalMessage: nil).console()
    }))
    
    CedroWebSocket.shared.subscribe(on: .businessBook("petr4", response: { businessBook in
        businessBook.logger(additionalMessage: nil).console()
    }))
    
    CedroWebSocket.shared.subscribe(on: .volumeAtPrice("petr4", response: { volumeAtPrice in
        volumeAtPrice.logger(additionalMessage: nil).console()
    }))
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        CedroWebSocket.shared.unsubscribe(on: .aggregatedBook("petr4"))
        CedroWebSocket.shared.unsubscribe(on: .detailedBook("petr4"))
        CedroWebSocket.shared.unsubscribe(on: .businessBook("petr4"))
        CedroWebSocket.shared.unsubscribe(on: .volumeAtPrice("petr4"))
    }
}

main()

RunLoop.current.run()

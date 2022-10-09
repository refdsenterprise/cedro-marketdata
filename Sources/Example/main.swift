import Foundation
import CedroWebSocket

func main() {
    let queue = DispatchQueue(label: "cedro.websocket", qos: .background, attributes: .concurrent)
    
    CedroWebSocket.shared.start(username: "any-username", password: "any-password")
    
    let subscribers: [CedroWebSocketService.Subscribe] = [
        .aggregatedBook("petr4") { $0.logger(additionalMessage: nil).console() },
        .detailedBook("petr4") { $0.logger(additionalMessage: nil).console() },
        .businessBook("petr4") { $0.logger(additionalMessage: nil).console() },
        .volumeAtPrice("petr4") { $0.logger(additionalMessage: nil).console() }
    ]
    
    let unsubscribers: [CedroWebSocketService.Unsubscribe] = [
        .aggregatedBook("petr4"),
        .detailedBook("petr4"),
        .businessBook("petr4"),
        .volumeAtPrice("petr4")
    ]
    
    subscribers.forEach { subscribe in
        queue.async {
            CedroWebSocket.shared.subscribe(on: subscribe)
        }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        unsubscribers.forEach { unsubscribe in
            queue.async {
                CedroWebSocket.shared.unsubscribe(on: unsubscribe)
            }
        }
    }
}

main()

RunLoop.current.run()

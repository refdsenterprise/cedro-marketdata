import Foundation
import CedroMarketData

func main() {
    let queue = DispatchQueue(label: "cedro.websocket", qos: .background, attributes: .concurrent)

    CedroMarketData.shared.start(username: "any-username", password: "any-password")

    let subscribers: [CedroMarketDataService.Subscribe] = [
        .aggregatedBook("petr4") { $0.logger(additionalMessage: nil).console() },
        .detailedBook("petr4") { $0.logger(additionalMessage: nil).console() },
        .businessBook("petr4", response: { response in
            response.logger(additionalMessage: nil).console()
        }, manager: { manager in
            manager.aggregatedBusinessBook.logger(additionalMessage: nil).console()
        }),
        .volumeAtPrice("petr4") { $0.logger(additionalMessage: nil).console() },
        .quote("petr4") { $0.logger(additionalMessage: nil).console(); $1.logger(additionalMessage: nil).console() },
        .candleChart("petr4", period: .oneMinute, realTime: true, response: { response in
            response.logger(additionalMessage: nil).console()
        }, manager: { manager in
            manager.candles.logger(additionalMessage: nil).console()
        })
    ]

    let unsubscribers: [CedroMarketDataService.Unsubscribe] = [
        .aggregatedBook("petr4"),
        .detailedBook("petr4"),
        .businessBook("petr4"),
        .volumeAtPrice("petr4"),
        .quote("petr4"),
        .candleChart("petr4")
    ]

    subscribers.forEach { subscribe in
        queue.async {
            CedroMarketData.shared.subscribe(on: subscribe)
        }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
        unsubscribers.forEach { unsubscribe in
            queue.async {
                CedroMarketData.shared.unsubscribe(on: unsubscribe)
            }
        }
    }
}

main()

RunLoop.current.run()

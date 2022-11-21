# Cedro Market Data

> Fornecer sinal de Market Data em que o recurso de cotação é entregue em streaming e em XML/JSON, disponível para os mercados B3 e Moedas.

[![CI](https://github.com/rafaelesantos/cedro-streaming-websocket/actions/workflows/swift.yml/badge.svg)](https://github.com/rafaelesantos/cedro-streaming-websocket/actions/workflows/swift.yml)
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Cedro WebSocket][cedro-image]][cedro-url]

### O que é API WebSocket?

Os serviços baseados na API WebSocket dão autorização para que as aplicações recebam os dados em tempo real. Por isso, ele é um serviço indicado para alimentar os serviços web de cotações em tempo real, aplicativos de trading, plataformas de investimentos, serviços de home broker, entre outros.

* Ideal para aplicações WEB (ex.: Home Broker) e aplicativos mobile;
* Sinal Streaming;
* Sinal Real-Time ou Delay;
* Cotações Bovespa, BM&F, Moedas e Indicadores.

### Funcionalidades

- [X] Livro de Ofertas Agregado - `Aggregated Book`
- [X] Livro de Ofertas Detalhado - `Detailed Book`
- [X] Cotação - `Quote`
- [X] Negócios Realizados Detalhado - `Detailed Business Book`
- [X] Negócios Realizados Agregado - `Aggregated Business Book`
- [X] Volume por Preço - `Volume At Price`
- [X] Gráfico de Candles - `Candle Chart`

### Instalação

Adicione esse projeto em seu arquivo `Package.swift`.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/cedro-marketdata.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["CedroMarketData"]),
    ]
)
```

### Como Utilizar

Para fazer uso da biblioteca é necessário importar o pacote `CedroMarketData`. Em seguida, acesse o singleton do package e faça a chamada da funcionalidade que deseja.

```swift
import CedroMarketData

class SomeViewController {
    func someFunction() {
        let queue = DispatchQueue(label: "cedro.marketData", qos: .background, attributes: .concurrent)
    
        CedroMarketData.shared.start(username: "any-username", password: "any-password")
    
        let subscribers: [CedroMarketDataService.Subscribe] = [
            .aggregatedBook("petr4") { $0.logger(additionalMessage: nil).console() },
            .detailedBook("petr4") { $0.logger(additionalMessage: nil).console() },
            .businessBook("petr4") { $0.logger(additionalMessage: nil).console() },
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
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            unsubscribers.forEach { unsubscribe in
                queue.async {
                    CedroMarketData.shared.unsubscribe(on: unsubscribe)
                }
            }
        }
    }
}
```

[swift-image]: https://img.shields.io/badge/swift-5.7-orange.svg
[swift-url]: https://www.swift.org/blog/swift-5.7-released/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[cedro-image]: https://img.shields.io/badge/WebSocket-Cedro-green.svg
[cedro-url]: https://www.marketdatacloud.com.br/APIs/websocket/

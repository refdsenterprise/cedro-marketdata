# Cedro Websocket

> WebSocket é uma API que estabelece conexões bilaterais de soquete entre um navegador e um servidor, permitindo assim a troca de dados com base em TCP. Ele fornece sinal de Market Data em que o recurso de cotação é entregue em streaming e em XML/JSON, disponível para os mercados B3 e Moedas.

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
- [ ] Cotação - `Quote`
- [X] Negócios Realizados - `Business Book`
- [ ] Gráfico de Candles - `Candle Chart`

### Instalação

Adicione esse projeto em seu arquivo `Package.swift`.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/cedro-websocket.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["CedroWebSocket"]),
    ]
)
```

### Como Utilizar

Para fazer uso da biblioteca é necessário importar o pacote `CedroWebSocket`. Em seguida, acesse o singleton do package e faça a chamada da funcionalidade que deseja.

```swift
import CedroWebSocket

class SomeViewController {
    func someFunction() {
        CedroWebSocket.shared.start(username: "any-username", password: "any-password")
    
    CedroWebSocket.shared.aggregatedBook("petr4") { aggregatedBook in
        aggregatedBook.logger(additionalMessage: nil).console()
    }
    
    CedroWebSocket.shared.detailedBook("vale3") { detailedBook in
        detailedBook.logger(additionalMessage: nil).console()
    }
    
    CedroWebSocket.shared.businessBook("petr4") { businessBook in
        businessBook.logger(additionalMessage: nil).console()
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

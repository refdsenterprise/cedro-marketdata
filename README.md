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

- [X] Login WebSocket
- [X] Livro de Ofertas Agregado - `Aggregated Book`
- [ ] Livro de Ofertas Detalhado - `Book`
- [ ] Cotação - `Quote`
- [ ] Negócios Realizados - `Quote Trade`
- [ ] Dados para `Candle Chart`

### Instalação

Adicione esse projeto em seu arquivo `Package.swift`.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/cedro-streaming-websocket.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["CedroStreamingWebSocket"]),
    ]
)
```

### Como Utilizar

Para fazer uso da biblioteca é necessário importar o pacote `CedroStreamingWebSocket`. Em seguida é necessário implementar o protocolo `...Delegate` do serviço que for consumir. Por fim, instancie o serviço e realize a chamada.

```swift
import CedroStreamingWebSocket

class ViewController: AggregatedBookDelegate {
    func configureAggregatedBook() {
        let aggregatedBook = makeAggregatedBook(token: "token", delegate: self)
        aggregatedBook.aggregatedBook(
            withRequestModel: GetAggregatedBookModel(
                token: "token",
                parameterGet: "petr4",
                parameters: GetAggregatedBookParameters(subsbribetype: .start)
            )
        )
    }
    
    // MARK: - AggregatedBookDelegate
    func aggregatedBook(didReceived aggregatedBookModel: AggregatedBookModel) {
        print(aggregatedBookModel)
    }
}
```

[swift-image]: https://img.shields.io/badge/swift-5.6-orange.svg
[swift-url]: https://www.swift.org/blog/swift-5.6-released/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[cedro-image]: https://img.shields.io/badge/WebSocket-Cedro-green.svg
[cedro-url]: https://www.marketdatacloud.com.br/APIs/websocket/

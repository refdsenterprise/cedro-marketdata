# Cedro Market Data

> Library to consume CedroTech API in a simple and organized way in real time and RestAPI of market data, authentication and order management system.

[![CI](https://github.com/rafaelesantos/cedro-streaming-websocket/actions/workflows/swift.yml/badge.svg)](https://github.com/rafaelesantos/cedro-streaming-websocket/actions/workflows/swift.yml)
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Cedro WebSocket][cedro-image]][cedro-url]

## Table of Contents
* [General Information](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Setup](#setup)
* [Usage](#usage)

## General Information

- The objective of this project is to analyze the flow of the market, separating it into moments to apply a strategy, returning when a purchase or sale should be made.
- All information and development steps are entered in jira boards.

## Technologies Used

- Xcode - version 14.1
- Swift Tools - version 5.7
- Swift Package Manager

## Features

- [X] Aggregated Book
- [X] Detailed Book
- [X] Quote
- [X] Detailed Business Book
- [X] Aggregated Business Book
- [X] Volume At Price
- [X] Candle Chart

## Setup

Add this project to your `Package.swift` file.

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

## Usage

To make use of the library it is necessary to import the `CedroMarketData` package. Then, access the package's singleton and call the functionality you want.

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

[swift-image]: https://img.shields.io/badge/Swift-5.7-orange.svg
[swift-url]: https://www.swift.org/blog/swift-5.7-released/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[cedro-image]: https://img.shields.io/badge/MarketData-Cedro-green.svg
[cedro-url]: https://www.marketdatacloud.com.br/

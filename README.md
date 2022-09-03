# Cedro Websocket

WebSocket é uma API que estabelece conexões bilaterais de soquete entre um navegador e um servidor, permitindo assim a troca de dados com base em TCP. Ele fornece sinal de Market Data em que o recurso de cotação é entregue em streaming e em XML/JSON, disponível para os mercados B3 e Moedas.

### O que é API WebSocket?

Os serviços baseados na API WebSocket dão autorização para que as aplicações recebam os dados em tempo real. Por isso, ele é um serviço indicado para alimentar os serviços web de cotações em tempo real, aplicativos de trading, plataformas de investimentos, serviços de home broker, entre outros.

* Ideal para aplicações WEB (ex.: Home Broker) e aplicativos mobile;
* Sinal Streaming;
* Sinal Real-Time ou Delay;
* Cotações Bovespa, BM&F, Moedas e Indicadores.

### O que posso e não posso fazer

* O funcionamento é por assinatura, ou seja, o usuário assina o comando uma única vez, e o servidor envia as atualizações;
* O usuário não pode simular REQUEST/RESPONSE;
* O usuário não pode redistribuir (FEED HANDLER);
* Modelo redistributor limitado a 50 assinaturas por conexão;
* Cliente pode ter acesso ao Tick-By-Tick;
* Não tem Histórico de Trades.

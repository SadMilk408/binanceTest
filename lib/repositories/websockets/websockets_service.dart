import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'websockets_service_interface.dart';

const miniTrackerChannel = 'wss://stream.binance.com:9443/ws/!miniTicker@arr';

class WebsocketsRepository implements WebsocketsRepositoryInterface {
  WebSocketChannel? _channel;

  @override
  Stream? get stream => _channel?.stream;

  @override
  Future<void> connect() async {
    try {
      final wsUrl = Uri.parse(miniTrackerChannel);
      _channel = IOWebSocketChannel.connect(wsUrl);
      await _channel?.ready;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  disconnect() {
    _channel?.sink.close();
  }
}

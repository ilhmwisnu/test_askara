import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class RemoteCryptoDataSource {
  final Uri _url =
      Uri.parse("wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo");

  late WebSocketChannel _channel;

  RemoteCryptoDataSource() {
    connect();
  }

  Stream<Map<String, dynamic>> get stream => _channel.stream.map(
        (message) => jsonDecode(message),
      );

  void connect() {
    _channel = WebSocketChannel.connect(_url);
  }

  Future<void> subscribe(String symbols) async {
    await _channel.ready;

    _channel.sink.add(jsonEncode({"action": "subscribe", "symbols": symbols}));
  }

  Future<void> unsubscribe(String symbols) async {
    await _channel.ready;

    _channel.sink
        .add(jsonEncode({"action": "unsubscribe", "symbols": symbols}));
  }

  Future<void> close() async {
    await _channel.sink.close(status.goingAway);
  }
}

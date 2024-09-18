import 'dart:async';

import '../data/remote/remote_crypto_datasource.dart';
import '../models/crypto.dart';

class CryptoRepository {
  final RemoteCryptoDataSource dataSource;

  CryptoRepository(this.dataSource);

  Stream<Crypto> getCryptoData() {
    final controller = StreamController<Crypto>.broadcast();

    () async {
      try {
        await for (var data in dataSource.stream) {
          if (data.containsKey("status_code") && data["status_code"] > 299) {
            controller.addError(Exception(data["message"]));
          } else if (data.containsKey("s")) {
            controller.add(Crypto.fromJson(data));
          }
        }
      } catch (e) {
        controller.addError(e);
      } finally {
        await controller.close();
      }
    }();

    return controller.stream;
  }

  Future<void> subscribe(String symbols) {
    return dataSource.subscribe(symbols);
  }

  Future<void> unsubscribe(String symbols) {
    return dataSource.unsubscribe(symbols);
  }

  Future<void> disconnect() {
    return dataSource.close();
  }
}

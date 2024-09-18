import 'package:test_askara/models/crypto.dart';

abstract class CryptoListEvent {}

class CryptoListSubscribe extends CryptoListEvent {}

class CryptoListUnsubscribe extends CryptoListEvent {}

class CryptoListListenData extends CryptoListEvent {}

class CryptoListUpdateData extends CryptoListEvent {
  CryptoListUpdateData(this.data);

  final Map<String, Crypto> data;
}

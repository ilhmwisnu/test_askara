import 'package:test_askara/models/crypto.dart';

abstract class CryptoDetailEvent {}

class CryptoDetailSubscribe extends CryptoDetailEvent {}

class CryptoDetailUnsubscribe extends CryptoDetailEvent {}

class CryptoDetailListenData extends CryptoDetailEvent {}

class CryptoDetailUpdateData extends CryptoDetailEvent {
  CryptoDetailUpdateData(this.data);

  final Crypto data;
}

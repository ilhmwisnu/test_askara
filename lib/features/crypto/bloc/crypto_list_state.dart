import 'package:test_askara/models/crypto.dart';

enum CryptoListStatus { initial, loading, dataRecieved, error }
final class CryptoListState {
  const CryptoListState({
    this.status = CryptoListStatus.initial,
    this.data = const {},
    this.errorMessage,
  });
  final CryptoListStatus status;
  final Map<String,Crypto> data;
  final String? errorMessage;
}
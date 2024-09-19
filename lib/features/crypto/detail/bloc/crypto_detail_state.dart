import 'package:test_askara/models/crypto.dart';

enum CryptoDetailStatus { initial, loading, dataRecieved, error }

final class CryptoDetailState {
  const CryptoDetailState({
    this.status = CryptoDetailStatus.initial,
    this.data = const [],
    this.errorMessage,
  });
  final CryptoDetailStatus status;
  final List<Crypto> data;
  final String? errorMessage;
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_event.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_state.dart';
import 'package:test_askara/models/crypto.dart';
import 'package:test_askara/repositories/crypto_repository.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final CryptoRepository cryptoRepository;
  Timer? _timer;
  StreamSubscription<Crypto>? cryptoSubs;

  CryptoListBloc(this.cryptoRepository) : super(const CryptoListState()) {
    on<CryptoListSubscribe>(_onSubscribe);
    on<CryptoListListenData>(_onListenData);
    on<CryptoListUnsubscribe>(_onUnsubscribe);
    on<CryptoListUpdateData>(_onUpdateData);
  }

  _onSubscribe(event, emit) {
    if (cryptoSubs != null) {
      cryptoSubs!.resume();
    }
    emit(const CryptoListState(status: CryptoListStatus.loading));
    cryptoRepository.subscribe("ETH-USD,BTC-USD");
  }

  _onListenData(event, emit) async {
    Map<String, Crypto> tempData = {};

    cryptoSubs = cryptoRepository.getCryptoData().listen((data) {
      tempData[data.s!] = data;
    }, onError: (e) {
      debugPrint(e.toString());
      emit(CryptoListState(
          status: CryptoListStatus.error, errorMessage: e.toString()));
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        add(CryptoListUpdateData(tempData));
      },
    );
  }

  _onUnsubscribe(event, emit) async {
    await cryptoRepository.unsubscribe("ETH-USD,BTC-USD");
    cryptoSubs?.pause();
  }

  _onUpdateData(event, emit) {
    emit(
      CryptoListState(
        status: CryptoListStatus.dataRecieved,
        data: event.data,
      ),
    );
  }

  @override
  Future<void> close() async {
    add(CryptoListUnsubscribe());
    _timer?.cancel();
    await cryptoRepository.disconnect();
    return super.close();
  }
}

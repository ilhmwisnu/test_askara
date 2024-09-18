import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_askara/repositories/crypto_repository.dart';

import 'crypto_detail_event.dart';
import 'crypto_detail_state.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  final CryptoRepository cryptoRepository;
  final String code;
  StreamSubscription? cryptoSubs;

  CryptoDetailBloc(this.cryptoRepository, this.code)
      : super(const CryptoDetailState()) {
    on<CryptoDetailSubscribe>(_onSubscribe);
    on<CryptoDetailListenData>(_onListenData);
    on<CryptoDetailUnsubscribe>(_onUnsubscribe);
    on<CryptoDetailUpdateData>(_onUpdateData);
  }

  _onSubscribe(event, emit) async {
    emit(const CryptoDetailState(status: CryptoDetailStatus.loading));
    await cryptoRepository.subscribe(code);
    add(CryptoDetailListenData());
  }

  _onListenData(event, emit) async {
    int lastUpdateInSec = 0;

    cryptoSubs = cryptoRepository.getCryptoData().listen((data) {
      int timeInSec = data.t! ~/ 1000;

      if (timeInSec > lastUpdateInSec && !isClosed) {
        add(CryptoDetailUpdateData(data));
        lastUpdateInSec = timeInSec;
      }
    }, onError: (e) {
      debugPrint(e.toString());
      emit(CryptoDetailState(
          status: CryptoDetailStatus.error, exception: e.toString()));
    });
  }

  _onUnsubscribe(event, emit) async {
    await cryptoRepository.unsubscribe(code);
  }

  _onUpdateData(CryptoDetailUpdateData event, emit) {
    emit(
      CryptoDetailState(
        status: CryptoDetailStatus.dataRecieved,
        data: List.from(state.data)..add(event.data),
      ),
    );
  }

  @override
  Future<void> close() async {
    add(CryptoDetailUnsubscribe());
    await cryptoSubs?.cancel();
    return super.close();
  }
}

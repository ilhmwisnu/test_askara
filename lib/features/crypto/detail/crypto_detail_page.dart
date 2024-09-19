import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_bloc.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_state.dart';
import 'component/crypto_line_chart.dart';

class CryptoDetailPage extends StatelessWidget {
  const CryptoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.read<CryptoDetailBloc>().code),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(left: 4, right: 24),
          child: BlocConsumer<CryptoDetailBloc, CryptoDetailState>(
            builder: (context, state) {
              if (state.status == CryptoDetailStatus.loading) {
                return const Center(child: const CircularProgressIndicator());
              }

              if (state.status == CryptoDetailStatus.dataRecieved) {
                return CryptoLineChart(
                  cryptoData: state.data,
                );
              }

              return const SizedBox();
            },
            listener: (context, state) {
              if (state.status == CryptoDetailStatus.error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            },
          ),
        ));
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_bloc.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_event.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_state.dart';

import 'component/crypto_datatable.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Watchlist")),
        body: BlocConsumer<CryptoListBloc, CryptoListState>(
          listener: (context, state) {
            if (state.status == CryptoListStatus.error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            if (state.status == CryptoListStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.status == CryptoListStatus.dataRecieved) {
              return CryptoDataTable(
                cryptoData: state.data.values.toList(),
                onTap: (crypto) async {
                  context.read<CryptoListBloc>().add(CryptoListUnsubscribe());
                  await context.push("/crypto/${crypto.s!}");

                  if (mounted) {
                    context.read<CryptoListBloc>().add(CryptoListSubscribe());
                  }
                },
              );
            }

            return SizedBox();
          },
        ));
  }
}

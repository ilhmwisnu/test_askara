// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_bloc.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_event.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_state.dart';

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
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("Code")),
                    DataColumn(label: Text("Last")),
                    DataColumn(label: Text("Chg")),
                    DataColumn(label: Text("Chg%")),
                  ],
                  rows: state.data.values.map(
                    (crypto) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            crypto.s!,
                            style: TextStyle(color: Colors.orange.shade700),
                          ),
                          onTap: () async {
                            context
                                .read<CryptoListBloc>()
                                .add(CryptoListUnsubscribe());
                            await context.push("/crypto/${crypto.s!}");

                            if (mounted) {
                              context
                                  .read<CryptoListBloc>()
                                  .add(CryptoListSubscribe());
                            }
                          },
                        ),
                        DataCell(Text(crypto.p!)),
                        DataCell(Text(crypto.dd!)),
                        DataCell(Text("${crypto.dc}%")),
                      ]);
                    },
                  ).toList(),
                ),
              );
            }

            return SizedBox();
          },
        ));
  }
}

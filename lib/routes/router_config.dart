import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_event.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_bloc.dart';
import 'package:test_askara/features/crypto/detail/bloc/crypto_detail_event.dart';
import 'package:test_askara/features/crypto/detail/crypto_detail_page.dart';
import 'package:test_askara/repositories/crypto_repository.dart';
import 'package:test_askara/data/remote/remote_crypto_datasource.dart';
import 'package:test_askara/features/crypto/bloc/crypto_list_bloc.dart';
import 'package:test_askara/features/crypto/crypto_list_page.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: "/crypto",
  routes: <RouteBase>[
    GoRoute(
      path: '/crypto',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) {
            return CryptoListBloc(CryptoRepository(RemoteCryptoDataSource()))
              ..add(CryptoListSubscribe())
              ..add(CryptoListListenData());
          },
          child: CryptoListPage(),
        );
      },
    ),
    GoRoute(
      path: '/crypto/:s',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) =>
              CryptoDetailBloc(CryptoRepository(RemoteCryptoDataSource()), state.pathParameters['s']!)
                ..add(CryptoDetailSubscribe())
                ..add(CryptoDetailListenData()),
          child: CryptoDetailPage(),
        );
      },
    ),
  ],
);

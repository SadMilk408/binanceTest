import 'package:binance_test/repositories/websockets/websockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/crypto_coins/bloc/crypto_coins_bloc.dart';
import 'features/crypto_coins/crypto_coins.dart';

void main() async {
  runApp(const BinanceApp());
}

class BinanceApp extends StatelessWidget {
  const BinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WebsocketsRepositoryInterface>(
          create: (context) => WebsocketsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CryptoCoinsBloc(
              websocketsRepository:
                  context.read<WebsocketsRepositoryInterface>(),
            ),
          ),
        ],
        child: const MaterialApp(
          themeMode: ThemeMode.dark,
          home: CoinsListScreen(),
        ),
      ),
    );
  }
}

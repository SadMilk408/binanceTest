import 'package:binance_test/ui/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/crypto_coins_bloc.dart';
import 'widgets/widgets.dart';

class CoinsListScreen extends StatefulWidget {
  const CoinsListScreen({super.key});

  @override
  State<CoinsListScreen> createState() => _CoinsListScreenState();
}

class _CoinsListScreenState extends State<CoinsListScreen> {
  @override
  void initState() {
    BlocProvider.of<CryptoCoinsBloc>(context).add(ConnectSocketEvent());
    BlocProvider.of<CryptoCoinsBloc>(context).add(ListenStreamEvent());
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<CryptoCoinsBloc>(context).add(DisconnectSocketEvent());
    super.dispose();
  }

  void search(String str) {
    BlocProvider.of<CryptoCoinsBloc>(context).add(SearchCoinEvent(str: str));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchField(search: search),
                const SizedBox(height: 50),
                BlocBuilder<CryptoCoinsBloc, CryptoCoinsState>(
                  builder: (context, state) {
                    if (state is CryptoCoinsLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CryptoCoinsFailure) {
                      return Text('${state.error}');
                    }
                    if (state is CryptoCoinsSuccess) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CointElement(
                            miniTickerModel: state.defaultCoins[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 25),
                        itemCount: state.defaultCoins.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

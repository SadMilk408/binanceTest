part of 'crypto_coins_bloc.dart';

sealed class CryptoCoinsEvent extends Equatable {
  const CryptoCoinsEvent();

  @override
  List<Object> get props => [];
}

class ConnectSocketEvent extends CryptoCoinsEvent {}

class ListenStreamEvent extends CryptoCoinsEvent {}

class DataStreamEvent extends CryptoCoinsEvent {
  final List<MiniTickerModel> defaultCoins;

  const DataStreamEvent({required this.defaultCoins});

  @override
  List<Object> get props => [defaultCoins];
}

class DisconnectSocketEvent extends CryptoCoinsEvent {}

class SearchCoinEvent extends CryptoCoinsEvent {
  final String str;

  const SearchCoinEvent({required this.str});
}

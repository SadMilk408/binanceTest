part of 'crypto_coins_bloc.dart';

sealed class CryptoCoinsState extends Equatable {
  const CryptoCoinsState();

  @override
  List<Object> get props => [];
}

final class CryptoCoinsInitial extends CryptoCoinsState {}

final class CryptoCoinsLoading extends CryptoCoinsState {}

final class CryptoCoinsSuccess extends CryptoCoinsState {
  const CryptoCoinsSuccess({required this.defaultCoins});

  final List<MiniTickerModel> defaultCoins;

  @override
  List<Object> get props => super.props..add(defaultCoins);
}

final class CryptoCoinsFailure extends CryptoCoinsState {
  const CryptoCoinsFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}

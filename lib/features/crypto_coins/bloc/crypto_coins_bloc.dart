import 'dart:convert';

import 'package:binance_test/repositories/websockets/websockets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/websockets/models/mini_ticker_model.dart';
import '../../../repositories/websockets/models/models.dart';

part 'crypto_coins_events.dart';
part 'crypto_coins_state.dart';

class CryptoCoinsBloc extends Bloc<CryptoCoinsEvent, CryptoCoinsState> {
  CryptoCoinsBloc({
    required WebsocketsRepositoryInterface websocketsRepository,
  })  : _websocketsRepository = websocketsRepository,
        super(CryptoCoinsInitial()) {
    on<ConnectSocketEvent>(_connect);
    on<ListenStreamEvent>(_listen);
    on<DataStreamEvent>(_dataStream);
    on<DisconnectSocketEvent>(_disconnect);
    on<SearchCoinEvent>(_search);
  }

  final WebsocketsRepositoryInterface _websocketsRepository;

  Future<void> _connect(
    ConnectSocketEvent event,
    Emitter<CryptoCoinsState> emit,
  ) async {
    try {
      emit(CryptoCoinsLoading());
      await _websocketsRepository.connect();
    } catch (e) {
      emit(CryptoCoinsFailure(e));
    }
  }

  List<MiniTickerModel> defaultCoins = [
    MiniTickerModel(
      tickerName: 'XRPUSDT',
    ),
    MiniTickerModel(
      tickerName: 'BNBUSDT',
    ),
    MiniTickerModel(
      tickerName: 'ETHUSDT',
    ),
    MiniTickerModel(
      tickerName: 'BTCUSDT',
    ),
  ];
  List<MiniTickerModel> matchQuery = [];
  bool searchNeedEmpty = false;

  Future<void> _listen(
    ListenStreamEvent event,
    Emitter<CryptoCoinsState> emit,
  ) async {
    _websocketsRepository.stream?.listen((data) {
      // decode from json to model
      List<dynamic> rellyAStringList = jsonDecode(data);

      List<MiniTickerModel> tempCoins = [];
      if (!searchNeedEmpty) {
        if (matchQuery.isEmpty) {
          tempCoins = defaultCoins;
        } else {
          tempCoins = matchQuery;
        }
      }

      for (Map<String, dynamic> string in rellyAStringList) {
        final model = MiniTickerModel.fromJson(string);

        // find matched coins
        for (final (index, el) in tempCoins.indexed) {
          if (el.tickerName == model.tickerName) {
            tempCoins[index] = model.copyWith(
              percentDiff: model.percentDifference(el.openValue),
            );
            break;
          }
        }
      }

      add(DataStreamEvent(defaultCoins: tempCoins));
    });
  }

  Future<void> _dataStream(
    DataStreamEvent event,
    Emitter<CryptoCoinsState> emit,
  ) async {
    emit(CryptoCoinsLoading());
    emit(CryptoCoinsSuccess(defaultCoins: event.defaultCoins));
  }

  Future<void> _disconnect(
    DisconnectSocketEvent event,
    Emitter<CryptoCoinsState> emit,
  ) async {
    _websocketsRepository.disconnect();
    emit(CryptoCoinsInitial());
  }

  Future<void> _search(
    SearchCoinEvent event,
    Emitter<CryptoCoinsState> emit,
  ) async {
    searchNeedEmpty = false;
    if (event.str == '') {
      matchQuery = [];
      emit(CryptoCoinsSuccess(defaultCoins: defaultCoins));
      return;
    }

    List<MiniTickerModel> match = [];

    for (var coin in defaultCoins) {
      if (coin.tickerName?.toLowerCase().contains(event.str.toLowerCase()) ??
          false) {
        match.add(coin);
      }
    }
    if (match.isNotEmpty) {
      matchQuery = match;
    } else if (event.str != '') {
      searchNeedEmpty = true;
    }

    emit(CryptoCoinsSuccess(defaultCoins: match));
  }
}

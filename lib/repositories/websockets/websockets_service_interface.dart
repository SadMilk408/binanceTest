enum ConnectStatus { done, failure }

abstract interface class WebsocketsRepositoryInterface {
  Stream? get stream;
  Future<void> connect();
  void disconnect();
}

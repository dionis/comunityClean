import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetwotkInfoImpl implements NetworkInfo {
  const NetwotkInfoImpl({required InternetConnectionChecker connection})
      : _connection = connection;
  final InternetConnectionChecker _connection;
  @override
  Future<bool> get isConnected => _connection.hasConnection;
}

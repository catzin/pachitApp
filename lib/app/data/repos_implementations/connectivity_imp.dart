import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pachitaapp/app/domain/repositories/connectivity_repository.dart';

class ConnectivityImp implements ConnectivityRepository {
  final Connectivity connectivity;

  ConnectivityImp({required this.connectivity});

  @override
  Future<bool> get hasInternet async {
    final connectResult = await connectivity.checkConnectivity();

    if (connectResult == ConnectivityResult.none) {
      return Future.delayed(const Duration(seconds: 1)).then((value) => false);
    }

    return Future.delayed(const Duration(seconds: 1)).then((value) => true);
  }
}

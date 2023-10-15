import '../models/user_information.dart';

abstract class AuthRepository {
  Future<String> loginWithEmail(String email, String password);
  Future<String> createAccount(Map<String, dynamic> dataUser);
  Future<bool> get isSignIn;
  Future<String> get idUser;
  Future<String> get currentUser;
  Future<UserInformation?> loginWithGoogle();
  void logOut();
}

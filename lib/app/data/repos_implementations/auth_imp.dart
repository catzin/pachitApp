// ignore: unused_import
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pachitaapp/app/domain/models/user_information.dart';
import 'package:pachitaapp/app/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthImp extends AuthRepository {
  
  final String baseUrl;
  final FlutterSecureStorage secureStorage;
  var dio = Dio();

  AuthImp({required this.secureStorage, required this.baseUrl});


@override
Future<String> createAccount(Map<String, dynamic> dataUser) async {
  var dio = Dio();

  try {
      final response = await dio.post('${baseUrl}auth/register',
          data: dataUser,
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {

       final Map<String, dynamic> usr = response.data;

      final String name = usr['nombre'];
      await secureStorage.write(key: 'name', value: name);
      await secureStorage.write(key: 'token', value: usr['token']);
      await secureStorage.write(key: 'id', value: usr['idusuario']);

      return name;
       
      } else {
        throw Exception('Error in the request register: ${response.statusCode}');
      }

    } catch (e) {

      throw Exception('Error in the request updateProfileImage: $e');

    }



 


    

 
}

  

  @override
  Future<String> get currentUser async {
    final name = await secureStorage.read(key: 'name');
    return name!;
  }

  @override
  Future<bool> get isSignIn async {
    final session = await secureStorage.read(key: 'token');
    return session != null;
  }

  @override
  void logOut() async {

    await secureStorage.delete(key: 'name');
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'id');
    await secureStorage.delete(key: 'tipo');
    await secureStorage.delete(key: 'peticion');
    await secureStorage.deleteAll();
  }

   @override
  Future<String> loginWithEmail(String email, String password) async {


    try{

      final Response response = await Dio().post(
        '${baseUrl}auth/login',
        data: {"correo": email, "contrasena":password },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> usr = response.data;

      final String name = usr['nombre'];
      final String iduser =
          usr['tipoUsuario_idTipoUsuario']['idTipoUsuario'].toString();
      await secureStorage.write(key: 'name', value: name);
      await secureStorage.write(key: 'token', value: usr['token']);
      await secureStorage.write(key: 'id', value: usr['idusuario']);
      await secureStorage.write(key: 'tipo', value: iduser);
      return name;

    
    } else {

        throw Exception('Error with status: ${response.statusCode}');
      
    }

    }catch(e){
       throw Exception('Error en login: $e');
    }
    
      
  }


  @override
  Future<String> get idUser async {
    final userid = await secureStorage.read(key: 'id');
    if (userid != null) {
      return userid;
    }
    return '';
  }

  @override
  Future<UserInformation?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

   
  
      final crendential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      final response =
          await FirebaseAuth.instance.signInWithCredential(crendential);
      final User? user = response.user;
    
      return UserInformation(
          displayName: user?.displayName,
          email: user?.email,
          photoURL: user?.photoURL);
    } catch (e) {
      print(e);
      throw Exception('Error en la solicitud google auth: $e');
    }
  }
}

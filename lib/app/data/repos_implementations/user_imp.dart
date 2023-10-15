// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pachitaapp/app/domain/models/change_status.dart';
import 'package:pachitaapp/app/domain/models/incidencias.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/domain/models/pet_register.dart';
import 'package:pachitaapp/app/domain/models/profile_adopt.dart';
import 'package:pachitaapp/app/domain/models/recordatorio.dart';
import 'package:pachitaapp/app/domain/models/reference_response.dart';
import 'package:pachitaapp/app/domain/models/referencia.dart';
import 'package:pachitaapp/app/domain/models/request_by_pet.dart';
import 'package:pachitaapp/app/domain/models/seguimientos.dart';
import 'package:pachitaapp/app/domain/models/status_request.dart';
import 'package:pachitaapp/app/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import '../../domain/models/adopt_request.dart';
import '../../domain/models/adoption_org.dart';
import '../../domain/models/evidenceResponse.dart';
import '../../domain/models/pets_user.dart';

class UserImp implements UserRepository {

  var dio = Dio();

  final FlutterSecureStorage secureStorage;
  final String baseUrl;

  UserImp({required this.baseUrl, required this.secureStorage});

  @override
  Future<List<Pet>> getAllPets() async {
    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/vertodasMascotas',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> resList = response.data;
        List<Pet> petList = resList.map((item) => Pet.fromJson(item)).toList();
        return petList;
      } else {
        throw Exception('Error en la solicitud getAllPets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getAllPets: $e');
    }
  }

  @override
  Future<List<Pet>> getPetsByType(String type) async {
    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/vertodasMascotasByTipo',
        queryParameters: {'tipoMascota': type},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> resList = response.data;
        List<Pet> petList = resList.map((item) => Pet.fromJson(item)).toList();
        return petList;
      } else {
        throw Exception('Error en la solicitud getPetsByType: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getPetsByType: $e');
    }
  }

  @override
  Future<List<Shelter>> getShelters() async {
    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/vertodasOrganizaciones',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> resList = response.data;
        List<Shelter> shelterList =
            resList.map((item) => Shelter.fromJson(item)).toList();
        return shelterList;
      } else {
        throw Exception('Error en la solicitud getShelters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getShelters: $e');
    }
  }

  @override
  Future<List<Pet>> getPetsByShelter(String id) async {
   
    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/mascotas-organizacion/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
      
        List<dynamic> resList = response.data;
        List<Pet> petList = resList.map((item) => Pet.fromJson(item)).toList();
        return petList.isNotEmpty ? petList : [];
      } else {
        throw Exception('Error en la solicitud getPetsByShelter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getPetsByShelter: $e');
    }
  }

  @override
  Future<RequestResponse> sendShelterRequest(Petition peticion) async {
    try {

      final token = await secureStorage.read(key:'token');
      final Response response = await Dio().post(
        '${baseUrl}user/peticion',
        data: {
          "idusuario": peticion.idusuario,
          "linkFacebook": peticion.linkFacebook,
          "linkInstagram": peticion.linkInstagram,
          "linkWeb": peticion.linkWeb,
          "motivo": peticion.motivo
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final RequestResponse res = RequestResponse.fromJson(response.data);
        return res;
      } else {
        throw Exception('Error en la solicitud sendShelterRequest: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud sendShelterRequest: $e');
    }
  }

  @override
  Future<bool> setPetition(String idpetition) async {
    await secureStorage.write(key: 'peticion', value: idpetition);
    final status = await secureStorage.read(key: 'peticion');
   
    return status != null;
  }

  @override
  Future<PetitionResponse> checkPetition() async {
    final id = await secureStorage.read(key:'peticion');
     final token = await secureStorage.read(key:'token');

    try {
      final Response response = await Dio().post(
        '${baseUrl}user/verificarStatus',
        data: {
          "idPeticion": id,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : token
          },
        ),
      );




      if (response.statusCode == 201 || response.statusCode == 200) {
        final PetitionResponse status =
            PetitionResponse.fromJson(response.data);
        return status;
      } else {
        throw Exception('Error en la solicitud checkPetition: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud checkPetition: $e');
    }
  }

  @override
  Future<bool> hasPetition() async {

    try{

      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/existPeticion',
        data: {
          "idusuario": id,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {

        final result =  response.data as Map<String, dynamic>;
        final exist = result['exist'];

        if(exist == 0){
          return false;
        }

        return true;
       

      } else {
        throw Exception('Error en la solicitud isshleterUser isShelterUser: ${response.statusCode}');
      }

    }catch(e){

      throw Exception('Error en la solicitud getPetsByShelter: $e');

    }

  }

  @override
  Future<Pet> registerPet(PetRegister data, List<String> images) async {
    final id = await secureStorage.read(key: 'id');
    final token = await secureStorage.read(key: 'token');

    final shelterID = await getIdShelter(id!);
    List<MultipartFile> files = [];

    for (int i = 0; i < images.length; i++) {
      File file = File(images[i]);
      String filename =
          "${DateTime.now().millisecondsSinceEpoch}.${images[i].split('.').last}";
      files.add(
        await MultipartFile.fromFile(file.path, filename: filename),
      );
    }

    final formData = FormData.fromMap({
      "nombre": data.name,
      "descripcion": data.descripcion,
      "edad": data.edad,
      "idtipoMascota": data.tipo,
      "idtipoRaza": data.tipoRaza,
      "idnivelActividad": data.tipoActividad,
      "estatus": data.status,
      "sexo": data.sexo,
      "caracteristicas": data.caracteristicas.join(','),
      "idOrganizacion": shelterID,
      "secureDisable":data.secureDisabled,
      "files": files,
    });

    try {
      final Response response = await Dio().post(
        '${baseUrl}organizacion/creaMascota',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data boundary=${formData.boundary}',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final petResponse = response.data as Map<String, dynamic>;
        final Pet pet = Pet.fromJson(petResponse['pet']);

        return pet;
       
      } else {
        throw Exception('Error en la solicitud registerPet: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud registerPet: $e');
    }
  }

  @override
  Future<Shelter> createShelter(Organization data, List<String> images) async {
    final id = await secureStorage.read(key: 'id');
    if (id == null) {
      throw Exception('id is null');
    }
    List<MultipartFile> files = [];

    for (int i = 0; i < images.length; i++) {
      File file = File(images[i]);
      String filename =
          "${DateTime.now().millisecondsSinceEpoch}.${images[i].split('.').last}";
      files.add(
        await MultipartFile.fromFile(file.path, filename: filename),
      );
    }

    final formData = FormData.fromMap({
      "idusuario": id,
      "nombre": data.nombre,
      "descripcion": data.descripcion,
      "fechaCreacion": data.fechaCreacion.toIso8601String(),
      "linkDonacion": data.linkDonacion,
      "files": files,
    });

    try {
      final Response response = await Dio().post(
        '${baseUrl}user/creaOrganizacion',
        data: formData,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data; boundary=${formData.boundary}',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final process = response.data as Map<String, dynamic>;
        final shelterJson = process['newOrganizacion'];
        await secureStorage.delete(key: 'peticion');

        return Shelter(
          idorganizacion: shelterJson['idorganizacion'],
          nombre: shelterJson['nombre'],
          descripcion: shelterJson['descripcion'],
          fechaCreacion: DateTime.parse(shelterJson['fechaCreacion']),
          linkInstagram: shelterJson['linkInstagram'],
          linkFacebook: shelterJson['linkFacebook'],
          fotoPerfil: shelterJson['fotoPerfil'],
          linkWeb: shelterJson['linkWeb'],
          fotoPortada: shelterJson['fotoPortada'],
          estatus: 1,
        );
      } else {
        throw Exception('Error en la solicitud createShelter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createShelter: $e');
    }
  }

  @override
  Future<dynamic> getIdShelter(String idUsuario) async {
    try {
      final Response response = await Dio().post(
        '${baseUrl}organizacion/idOrganizacion',
        data: {
          "userId": idUsuario,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final shelterId = response.data as Map<String, dynamic>;
        return shelterId['idOrganizacion'];
      } else {
        throw Exception('Error en la solicitud getIdShelter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getIdShelter: $e');
    }
  }

  @override
  Future<String> isShelterUser() async {
    try {
      final session = await secureStorage.read(key: 'id');
     
      final Response response = await Dio().post(
        '${baseUrl}user/tipoUsuario',
        data: {
          "idusuario": session,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {

        final result =  response.data as Map<String, dynamic>;
        
        final idTipoUsuario = result['result']['idTipoUsuario'].toString();
       
        return idTipoUsuario;

      } else {
        throw Exception('Error en la solicitud isshleterUser isShelterUser: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud isshleterUser isShelterUser: $e');
    }
  }

  @override
  Future<dynamic> sendAdoptPetition(Map<String, dynamic> data) async {
    try {
      final id = await secureStorage.read(key: 'id');
      data['usuario'] = id;

      final Response response = await Dio().post(
        '${baseUrl}user/solicitudAdopcion',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return responseData;
      } else {
        throw Exception('Error en la solicitud sendAdoptPetition: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud sendAdoptPetition: $e');
    }
  }

 

  @override
  Future<void> registerAddress(Map<String, dynamic> data) async {
    try {
      final id = await secureStorage.read(key: 'id');

      data['usuario_idusuario'] = id;
      final Response response = await Dio().post(
        '${baseUrl}user/creaUbicacion',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    
      if (response.statusCode == 201 || response.statusCode == 200) {
        //final responseData = json.decode(response.data);
        return response.data;
      } else {
        throw Exception(
            'Error en la solicitud registerAddress:  ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud registerAddress: $e');
    }
   
  }


  @override
  Future<String> getUserImageProfile() async {
    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/getImageProfile',
        data: {"idUsuario": id},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return responseData['image'];
      } else {
        throw Exception('Error en la solicitud getUserImageProfile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getUserImageProfile: $e');
    }
  }

  @override
  Future<String> updateProfileImage(String pathImage) async {
    try {
      final id = await secureStorage.read(key: 'id');
      //final token = await secureStorage.read(key: 'token');

      final File file = File(pathImage);
      String filename =
          "${DateTime.now().millisecondsSinceEpoch}.${pathImage.split('.').last}";

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: filename,
        ),
        "idUsuario": id,
      });

      final Response response = await Dio().post(
        '${baseUrl}user/profileimage',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            // 'Authorization': 'Bearer $token'
          },

        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final image = response.data as Map<String, dynamic>;
        return image['imageUrl'];
      } else {
        throw Exception('Error in the request updateProfileImage: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in the request updateProfileImage: $e');
    }
  }

  @override
  void setValueKey(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<Placemark?> getAddres(String lat, String long)async{
    try {

    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(lat), double.parse(long));
    // ignore: unnecessary_null_comparison
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
  
      return placemark;
    }
      
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<EditUser> getUsetInformation()async{
    try {
      final id = await secureStorage.read(key: 'id');
      final token = await secureStorage.read(key: 'token');
    

      final Response response = await Dio().post(
        '${baseUrl}user/find',
        data: {"idUsuario": id},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return EditUser.fromJson(responseData);
      } else {
        throw Exception('Error en la solicitud getUsetInformation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getUsetInformation: $e');
    }
   
  }
  
  @override
  Future <Recordatorio> createReminder(Map<String, dynamic> data)async{
    try {
      final token = await secureStorage.read(key: 'token');
     
      final Response response = await Dio().post(
        '${baseUrl}organizacion/creaRecordatorio',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
     
        final responseData = response.data as Map<String, dynamic>;
        return Recordatorio.fromJson(responseData['accept']);
      
      } else {
       
        throw Exception('Error en la solicitud createReminder: ${response.statusCode}');
      }
    } catch (e) {
      
      throw Exception('Error en la solicitud createReminder: $e');
    }
  }
  
  @override
  Future verifyAddress()async{

    final id = await secureStorage.read(key: 'id');

    try {

      final Response response = await Dio().post(
        '${baseUrl}user/verUsersUbicacion',
        data: {
          "idUsuario": id

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String, dynamic >responseData = response.data as Map<String, dynamic>;
        return responseData['ubicacion']['idUbicacion'];
      
      } else {
        throw Exception('Error en la solicitud verifyAddress: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud verifyAddress: $e');
    }
   

  }
  
  @override
  Future<Pet> likePet(int idPet)async{

    final id = await secureStorage.read(key: 'id');

    try {

      final Response response = await Dio().post(
        '${baseUrl}user/likeMascota',
        data: {
          "mascota":idPet,
          "usuario": id

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String, dynamic >responseData = response.data as Map<String, dynamic>;
        return Pet.fromJson(responseData['accept']);
      
      } else {
        throw Exception('Error en la solicitud likePet: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud likePet: $e');
    }
  
  }

  @override
  Future<ProfileAdopt> searchInfoAdopt()async{

    try {
      final id = await secureStorage.read(key:'id');
      final token = await secureStorage.read(key:'token');

      final Response response = await Dio().post(
        '${baseUrl}user/perfil-adopcion',
        data: {"idUsuario": id},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
            
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return ProfileAdopt.fromJson(responseData);
      } else {
        throw Exception('Error en la solicitud searchInfoAdopt: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud searchInfoAdopt: $e');
    }
 

  }

  @override
  Future<ReferenceResponse> createRefence(Map<String , dynamic> datar)async{

    try {
      final id = await secureStorage.read(key: 'id');

      datar['idUsuario'] = id;

      final Response response = await Dio().post(
        '${baseUrl}user/crearReferencia',
        data:datar,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return ReferenceResponse.fromJson(responseData);
      } else {
        throw Exception('Error en la solicitud createRefence: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createRefence: $e');
    }
  
  }
  
  @override
  Future <List<Referencia>>searchReferenceData()async{

    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/crearReferencia',
        data:{
          "idUsuario" : id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic>  dataList = json.decode(responseData['referencias']);
        final List<Referencia> referencesList = dataList.map((e) => Referencia.fromJson(e)).toList();
        return List.from(referencesList);
      } else {
        throw Exception('Error en la solicitud createRefence: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createRefence: $e');
    }
    
  }
  
  @override
  Future deleteReference(String idReferencia)async{

     try {
    
      final Response response = await Dio().post(
        '${baseUrl}user/eliminarReferencia',
        data:{
          "idReferencia" : idReferencia
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data as Map<String , dynamic>;
      } else {
        throw Exception('Error en la solicitud createRefence: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createRefence: $e');
    }
  
  }
  
  @override
  Future <Ubicacion>getUserAddressInfo()async{
    try {

      final id = await secureStorage.read(key: 'id');
      final Response response = await Dio().post(
        '${baseUrl}user/verUsersUbicacion',
        data:{
          "idUsuario" : id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res =  response.data as Map<String , dynamic>;
        return Ubicacion.fromJson(res['ubicacion']);
      } else {
        throw Exception('Error en la solicitud createRefence: ${response.statusCode}');
      }
      
    } catch (e) {
       throw Exception('Error en la solicitud getUserAddressInfo: $e');
      
    }
  }

  @override
  Future<List<Recordatorio>> listReminders(String shelterID) async {
    
    try {
      final token = await secureStorage.read(key: 'token');
   
      final Response response = await Dio().post(
        '${baseUrl}organizacion/verRecordatorios',
        data: {"idOrg": shelterID},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },

        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        final List<dynamic> recordatoriosData = res['recordatoriosFound'];

        return recordatoriosData.map((e) => Recordatorio.fromJson(e)).toList();
      } else {
        throw Exception(
            'Error en la solicitud verRecordatorios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud verRecordatorios: $e');
    }
  }

  @override
  Future adoptRequest(String idMascota) async {
    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/verRecordatorios',
        data: {
          "fechaSolicitud": DateTime.now().toIso8601String(),
          "mascota": idMascota,
          "usuario": id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        final List<dynamic> recordatoriosData = res['recordatoriosFound'];

        return recordatoriosData.map((e) => Recordatorio.fromJson(e)).toList();
      } else {
        throw Exception(
            'Error en la solicitud adoptRequest: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud adoptRequest: $e');
    }
  }
  
  @override
  Future isMyShelter()async{
    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/shelter-user',
        data: {
          "idUsuario": id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
        

        return res['orgName'];
      } else {
        throw Exception(
            'Error en la solicitud adoptRequest: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud adoptRequest: $e');
    }
   
  }
  
  @override
  Future<Shelter> findMyShelter()async{
    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}organizacion/miOrganizacion',
        data: {
          "idusuario": id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
      
        return Shelter.fromJson(res['org']);
      } else {
        throw Exception(
            'Error en la solicitud findMyShelter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud findMyShelter: $e');
    }

  }
  
  @override
  Future<int> likesPet(int idmascota)async{
    try {
      final Response response = await Dio().post(
        '${baseUrl}user/mascotaLikes',
        data: {
          "idmascota": idmascota
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final res = response.data as Map<String, dynamic>;
      
        return res['likes'];
      } else {
        throw Exception(
            'Error en la solicitud likesPet: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud likesPet: $e');
    }

    
  }
  
  @override
  Future<int> dislikePet(int idPet)async{

     final id = await secureStorage.read(key: 'id');
    try {

      final Response response = await Dio().post(
        '${baseUrl}user/dislikeMascota',
        data: {
          "mascota":idPet,
          "usuario": id

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String, dynamic >responseData = response.data as Map<String, dynamic>;
        return responseData['result'];
      
      } else {
        throw Exception('Error en la solicitud dislikePet: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud dislikePet: $e');
    }
   
  }
  
  @override
  Future<List<Pet>> favoritePets() async {
    final id = await secureStorage.read(key: 'id');
    try {
      
        final Response response = await Dio().post(
          '${baseUrl}user/mascotasFavoritas',
          data: {"idUsuario": id},
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {

        final responseData = response.data as Map<String, dynamic>;
        List<dynamic> listjson = responseData['pets'];
        final List<Pet> pets =
            listjson.map((e) => Pet.fromJson(e['mascota'])).toList();
          return pets;

        } else {
          throw Exception(
              'Error en la solicitud favoritePets: ${response.statusCode}');
        }
      
    } catch (e) {
      throw Exception('Error en la solicitud favoritePets: $e');
    }
  }
  
  @override
  Future updateInfoUser(Map<String, dynamic> data)async{
    final id = await secureStorage.read(key: 'id');
    data['idusuario'] = id;
    try {

      final Response response = await Dio().patch(
        '${baseUrl}user/updateInfo',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String, dynamic >responseData = response.data as Map<String, dynamic>;
   
        return responseData;
      
      } else {
        throw Exception('Error en la solicitud updateInfoUser: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud updateInfoUser: $e');
    }
    
    
  }
  
  @override
  Future<AdoptionRequest> sendAdoptRequest(Map<String, dynamic> data)async{

    final id = await secureStorage.read(key: 'id');
    final token = await secureStorage.read(key: 'token');
    data['usuario'] = id;


    try {

      final Response response = await Dio().post(
        '${baseUrl}user/solicitudAdopcion',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String, dynamic >responseData = response.data as Map<String, dynamic>;
   
        return AdoptionRequest.fromJson(responseData);
      
      } else {
        throw Exception('Error en la solicitud sendAdoptRequest: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud sendAdoptRequest: $e');
    }
  }
  
  @override
  Future<int> signature(Uint8List signatureImage)async{

     try {

      final id = await secureStorage.read(key: 'id');

      final formData = FormData();
      formData.files.add(
        MapEntry('file', MultipartFile.fromBytes(
          signatureImage,
          filename: 'firma.png',
        ))
      );

      formData.fields.add(MapEntry('idusuario', id!));

      final Response response = await Dio().post(
        '${baseUrl}organizacion/firmar',
        data:formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return responseData['success'];
      
      } else {
        throw Exception('Error en la solicitud signature: ${response.statusCode}');
      }
      
    } catch (e) {
        throw Exception('Error en la solicitud signature: $e');
    }
    
  }
  
  @override
  Future<bool> uploadResidenceEvidence(List<String> images)async{

    try{

      final id = await secureStorage.read(key: 'id');

      if (id == null) {
        throw Exception('id is null');
      }
      List<MultipartFile> files = [];

      for (int i = 0; i < images.length; i++) {
        File file = File(images[i]);
        String filename =
            "${DateTime.now().millisecondsSinceEpoch}.${images[i].split('.').last}";
        files.add(
          await MultipartFile.fromFile(file.path, filename: filename),
        );
      }

      final formData = FormData.fromMap({
        "idusuario": id,
        "files": files,
      });

      final Response response = await Dio().post(
        '${baseUrl}user/domicilioEvidencia',
        data: formData,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data; boundary=${formData.boundary}',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        // ignore: unused_local_variable
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return  true;
      
      } else {
        throw Exception('Error en la solicitud uploadResidenceEvidence: ${response.statusCode}');
      }

    }catch(e){
      throw Exception('Error en la solicitud uploadResidenceEvidence:$e');

    }



  }
  
  @override
  Future<EvidenceResponse>verifyResidenceEvidence()async{
    try{

      final id = await secureStorage.read(key: 'id');

       final Response response = await Dio().post(
        '${baseUrl}user/verificaEvidencia',
        data:{
          "idusuario":id
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return  EvidenceResponse.fromJson(responseData);
      
      } else {
        throw Exception('Error en la solicitud verifyResidenceEvidence: ${response.statusCode}');
      }

    }catch(e){

       throw Exception('Error en la solicitud verifyResidenceEvidence: $e');

    }


  }
  
  @override
  Future<bool> registerContactHour(String data)async{

    try{
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}user/registraHorario',
        data:{
          "idUsuario":id,
          "horario":data
        }
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        //final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return  true;
      
      } else {
        throw Exception('Error en la solicitud registerContactHour: ${response.statusCode}');
      }




    }catch(e){
       throw Exception('Error en la solicitud registerContactHour: $e');
    }
  }

  @override
  Future<bool>updateContactHour(String data)async{

    try{
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().patch(
        '${baseUrl}user/updateHorario',
        data:{
          "idUsuario":id,
          "horario":data
        }
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        //final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
       
        return true;
      
      } else {
        throw Exception('Error en la solicitud updateContactHour: ${response.statusCode}');
      }

    }catch(e){
       throw Exception('Error en la solicitud updateContactHour: $e');
    }

  }
  
  @override
  Future<Map<String,dynamic>> getContactHour()async{
    try{
      final id = await secureStorage.read(key: 'id');



      final Response response = await Dio().post(
        '${baseUrl}user/horarioContacto',
        data:{ "idusuario":id}
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
       
        return  responseData['response'];
      
      } else {
        throw Exception('Error en la solicitud getContactHour: ${response.statusCode}');
      }

    }catch(e){
       throw Exception('Error en la solicitud getContactHour: $e');
    }
    
  }
  
  @override
  Future<bool> registerIncidence(Map<String, dynamic> data)async{

    try{
     
      final Response response = await Dio().post(
        '${baseUrl}organizacion/crearIncidencia',
        data:{
          "idmascota":data['idmascota'],
          "gasto":data['gasto'],
          "motivo":data['motivo'],
          "fecha":data['fecha']

        }
      
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        //final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return  true;
      
      } else {
        throw Exception('Error en la solicitud registerIncidence: ${response.statusCode}');
      }

    }catch(e){
       throw Exception('Error en la solicitud registerIncidence: $e');
    }

  }

  @override
  Future<List<Incidencia>> listIncidences(int idPet)async{
     try{
     
      final Response response = await Dio().post(
        '${baseUrl}organizacion/listarIncidencias',
        data:{ "idmascota":idPet}
      
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        final result =  Incidencias.fromJson(responseData).incidencias;
        return result;
      
      } else {
        throw Exception('Error en la solicitud listIncidences: ${response.statusCode}');
      }

    }catch(e){
       throw Exception('Error en la solicitud listIncidences: $e');
    }
  }
  
  @override
  Future<List<PetU>> listPetsOrganizationByUser()async{

    try{

      final id = await secureStorage.read(key: 'id');
     
      final Response response = await Dio().post(
        '${baseUrl}organizacion/petsByUser',
        data:{ "idusuario":id}
      
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        final pets =PetsUser.fromJson(responseData);
        return pets.pets;
      
      } else {
        throw Exception('Error en la solicitud listIncidences: ${response.statusCode}');
      }

    }catch(e){
       throw Exception('Error en la solicitud listIncidences: $e');
    }
   
  }
  
  @override
  Future<String> getPetProfileImage(int idPet)async{
     try {
      final Response response = await Dio().post(
          '${baseUrl}organizacion/imagenAleatoriaMascota',
          data: {"idmascota": idPet});

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;

        return responseData["image"];
      } else {
        throw Exception(
            'Error en la solicitud listIncidences: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud listIncidences: $e');
    }
   
  }
  
  @override
  Future<List<PetOrgRequest>> findPetsWithRequest()async{

    try {

      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
          '${baseUrl}organizacion/verMascotasConSolicitudes',
        data: {"idusuario": id},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        final AdoptionOrgRequest data = AdoptionOrgRequest.fromJson(responseData);

        return data.pets;
      } else {
        throw Exception(
            'Error en la solicitud findPetsWithRequest: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud findPetsWithRequest: $e');
    }

  }
  
  @override
  Future<List<Solicitude>> findUserRequest()async{
     try {

      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
          '${baseUrl}user/solicitudes',
        data: {"idusuario": id},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        final  StatusRequest res = StatusRequest.fromJson(responseData);

        return res.solicitudes;

      } else {
        throw Exception(
            'Error en la solicitud solicitudes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud solicitudes: $e');
    }
 
  }

  @override
  Future<List<RequestPet>> requestByPet(int idPet) async {
    try {


      final Response response = await Dio().post(
        '${baseUrl}organizacion/solicitudPorMascota',
        data: {"idMascota": idPet},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;
        final RequestByPet res = RequestByPet.fromJson(responseData);

        return res.request;
      } else {
        throw Exception(
            'Error en la solicitud requestByPet: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud requestByPet: $e');
    }
  }
  
  @override
  Future<List<Pet>> getPetsByAge(int key, int type)async{

    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/vertodasMascotasByNivel/?edad=$key&tipo=$type',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> resList = response.data;
        List<Pet> petList = resList.map((item) => Pet.fromJson(item)).toList();
        return petList;
      } else {
        throw Exception('Error en la solicitud getPetsByAge: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getPetsByAge: $e');
    }

  }
  
  @override
  Future<List<Pet>> getPetsByActivity(int key, int type)async{

    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/vertodasMascotasByNivel/?nivelActividad=$key&tipo=$type',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> resList = response.data;
        List<Pet> petList = resList.map((item) => Pet.fromJson(item)).toList();
        return petList;
      } else {
        throw Exception('Error en la solicitud getPetsByAge: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getPetsByAge: $e');
    }

  }

  @override
  Future<Solicitud> changeStatusRequest(int idSolicitud, int newStatus)async{
      try {
      final Response response = await Dio().patch(
        '${baseUrl}mascota/solicitud',
        data: {
          "idsolicitud":idSolicitud,
          "nuevo":newStatus

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
  
        ChangeStatus resSol = ChangeStatus.fromJson(responseData);
        return resSol.solicitud;
      } else {
        throw Exception('Error en la solicitud changeStatusRequest: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud changeStatusRequest: $e');
    }


  }
  
  @override
  Future<bool> uploadDocumentEvidence(List<String> images)async{
    try{

      final id = await secureStorage.read(key: 'id');

      if (id == null) {
        throw Exception('id is null');
      }
      List<MultipartFile> files = [];

      for (int i = 0; i < images.length; i++) {
        File file = File(images[i]);
        String filename =
            "${DateTime.now().millisecondsSinceEpoch}.${images[i].split('.').last}";
        files.add(
          await MultipartFile.fromFile(file.path, filename: filename),
        );
      }

      final formData = FormData.fromMap({
        "idusuario": id,
        "files": files,
      });

      final Response response = await Dio().post(
        '${baseUrl}user/documentoEvidencia',
        data: formData,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data; boundary=${formData.boundary}',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
  
        // ignore: unused_local_variable
        final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
        return  true;
      
      } else {
        throw Exception('Error en la solicitud uploadDocuments: ${response.statusCode}');
      }

    }catch(e){
      throw Exception('Error en la solicitud uploadDocuments:$e');

    }
    
  }
  
  @override
  Future sendPDFContract(String organitationName, String adopter, String additionalClause)async{

    try {
      final Response response = await Dio().get(
        '${baseUrl}organizacion/pdf',
        data: {
          "organizationName":organitationName,
          "adopterName":adopter,
          "additionalClause":additionalClause

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
   
        return true;
      } else {
        throw Exception('Error en la solicitud getPetsByAge: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud getPetsByAge: $e');
    }

  }
  
  @override
  Future<String> getShelterName()async{


    try {

      final id = await secureStorage.read(key: 'id');
      final Response response = await Dio().get(
        '${baseUrl}organizacion/nombreOrganizacion',
        data: {
         "idorganizacion":id

        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {

         final Map<String,dynamic> responseData = response.data as Map<String, dynamic>;
   
        return responseData['name'];
      } else {
        throw Exception('Error en la solicitud nombreOrganizacion: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud nombreOrganizacion: $e');
    }
    
   
  }
  
  @override
  Future createAdoption(Map<String,dynamic>data)async{

    try {


      final Response response = await Dio().post(
        '${baseUrl}mascota/adopcion',
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;
     
        return true;
      } else {
        throw Exception(
            'Error en la solicitud createAdoption: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createAdoption: $e');
    }
 
  }

  @override
  Future<List<Seguimiento>> getSeguimientosByuser()async{
    try {
      final id = await secureStorage.read(key: 'id');

      final Response response = await Dio().post(
        '${baseUrl}mascota/seguimientos',
        data:{
          "idusuario" : id
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final Seguimientos res = Seguimientos.fromJson(responseData);
  
        return res.seguimientos;
      } else {
        throw Exception('Error en la solicitud createRefence: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud createRefence: $e');
    }
  }

  
   
  
}
  
  
  
  

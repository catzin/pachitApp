
import 'dart:convert';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/domain/models/parentesco_item.dart';
import '../../domain/repositories/index.dart';


class CatalogImp implements CatalogsRepository{

  final String baseUrl;
  final GetConnect _client = Get.find<GetConnect>();

  CatalogImp({required this.baseUrl});

  @override
  Future<List<Sex>> get sex async{
    
    final Response response = await _client.get(
      '${baseUrl}catalogs/sexos',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
        //print(response.body.runtimeType);
        List<dynamic> resList = json.decode(response.bodyString!);
        List<Sex> sexList = resList.map((item) => Sex.fromJson(item)).toList();
        return sexList;

      }catch(e){
      throw Exception(e);

      }
      
    } 
  }


  @override
  Future<List<Ocupation>> get ocupations async{

    final Response response = await _client.get(
      '${baseUrl}catalogs/ocupaciones',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
      throw response.statusText!;
    } else{

      try{
        //print(response.body.runtimeType);
        List<dynamic> resList = json.decode(response.bodyString!);
        List<Ocupation> ocupationList = resList.map((item) => Ocupation.fromJson(item)).toList();
        return ocupationList;

      }catch(e){
      throw Exception(e);

      }
      
    }


  }
  
  @override
  Future<List<CivilState>> get civilState async{

    final Response response = await _client.get(
      '${baseUrl}catalogs/estadoCivil',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
     
        List<dynamic> resList = json.decode(response.bodyString!);
        List<CivilState> civilList = resList.map((item) => CivilState.fromJson(item)).toList();
        return civilList;

      }catch(e){
      throw Exception(e);
      }
    }
  }
  
  @override
  Future<List<Residence>> get residence async{

     final Response response = await _client.get(
      '${baseUrl}catalogs/domicilios',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<Residence> domList = resList.map((item) => Residence.fromJson(item)).toList();
        return domList;
      }catch(e){
      throw Exception(e);

      }
      
    }

  }
  
  @override
  Future<List<NivelActividad>> get activityLevels async{
    final Response response = await _client.get(
      '${baseUrl}organizacion/nivelActividad',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
      throw response.statusText!;
    } else {
      try {
        List<dynamic> resList = json.decode(response.bodyString!);
        List<NivelActividad> activitiesList =
            resList.map((item) => NivelActividad.fromJson(item)).toList();
        return activitiesList;
      } catch (e) {
        throw Exception(e);
      }
    }
  }
  
  @override
  Future<List<CaracteristicasType>> get caracteristicas async{
    final Response response = await _client.get(
      '${baseUrl}organizacion/caracteristicas',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<CaracteristicasType> caractsList = resList.map((item) => CaracteristicasType.fromJson(item)).toList();
        return caractsList;
      }catch(e){
      throw Exception(e);

      }
      
    }

  }
  
  @override
  Future<List<PetType>> get petType async{
    final Response response = await _client.get(
      '${baseUrl}organizacion/tipoMascota',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<PetType> typeList = resList.map((item) => PetType.fromJson(item)).toList();
        return typeList;
      }catch(e){
      throw Exception(e);

      }
      
    }

  }
  
  @override
  Future<List<RazaType>> get razas async{

    final Response response = await _client.get(
      '${baseUrl}organizacion/raza',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
 
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<RazaType> razaList = resList.map((item) => RazaType.fromJson(item)).toList();
        return razaList;
      }catch(e){
      throw Exception(e);

      }
    }
  }
  
  @override
  Future<List<PetAgeResponse>> get petEdad async{
    final Response response = await _client.get(
      '${baseUrl}catalogs/perroEdad',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<PetAgeResponse> ageList = resList.map((item) => PetAgeResponse.fromJson(item)).toList();
        return ageList;
      }catch(e){
      throw Exception(e);

      }
      
    }
  }

  @override
  Future<List<ParentescoItem>> get parentescos async{
     final Response response = await _client.get(
      '${baseUrl}catalogs/parentesco',
      headers:  {'Content-Type': 'application/json'},
    );

    if (response.status.hasError) {
      throw response.statusText!;
    } else{

      try{
        List<dynamic> resList = json.decode(response.bodyString!);
        List<ParentescoItem> parenList = resList.map((item) => ParentescoItem.fromJson(item)).toList();
        return parenList;
      }catch(e){
      throw Exception(e);

      }
      
    }
  }
    
}
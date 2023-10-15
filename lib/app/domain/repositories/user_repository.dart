
import 'dart:typed_data';

import 'package:geocoding/geocoding.dart';
import 'package:pachitaapp/app/domain/models/pet_register.dart';
import 'package:pachitaapp/app/domain/models/referencia.dart'; 
import '../models/adopt_request.dart';
import '../models/adoption_org.dart';
import '../models/change_status.dart';
import '../models/evidenceResponse.dart';
import '../models/incidencias.dart';
import '../models/index.dart';
import '../models/pets_user.dart';
import '../models/profile_adopt.dart';
import '../models/recordatorio.dart';
import '../models/reference_response.dart';
import '../models/request_by_pet.dart';
import '../models/seguimientos.dart';
import '../models/status_request.dart';

abstract class UserRepository{
  
  Future<List<Pet>> getAllPets();
  Future<List<Pet>> getPetsByAge(int key, int type);
  Future<List<Pet>> getPetsByActivity(int key, int type);
  Future<List<Pet>> getPetsByShelter(String id);
  Future<List<Pet>> getPetsByType(String type);
  Future<List<Shelter>> getShelters();
  Future<RequestResponse> sendShelterRequest(Petition peticion);
  Future <bool> setPetition(String idpetition);
  Future<bool> hasPetition();
  void setValueKey(String key, String value);
  Future <PetitionResponse> checkPetition();
  Future<dynamic> getIdShelter(String idUsuario);
  Future<Shelter> createShelter(Organization data, List<String> images);
  Future<Pet> registerPet(PetRegister data , List<String> images);
  Future<String> isShelterUser();
  Future<dynamic> sendAdoptPetition(Map<String,dynamic> data);
  Future<Placemark?> getAddres(String lat , String long);
  Future<dynamic> registerAddress(Map<String, dynamic> data);
  Future<EditUser> getUsetInformation();
  Future<dynamic> getUserImageProfile();
  Future<dynamic> updateProfileImage(String pathImage);
  Future<Recordatorio> createReminder(Map<String, dynamic> data);
  Future<dynamic> verifyAddress();
  Future<Pet> likePet(int idPet);
  Future<int> dislikePet(int idPet);
  Future<ProfileAdopt> searchInfoAdopt();
  Future<ReferenceResponse> createRefence(Map<String , dynamic> data);
  Future<List<Referencia>>searchReferenceData();
  Future<dynamic> deleteReference(String idReferencia);
  Future<Ubicacion> getUserAddressInfo();
  Future<List<Recordatorio>> listReminders(String shelterID);
  Future<dynamic> adoptRequest(String idMascota);
  Future<dynamic> isMyShelter();
  Future<Shelter> findMyShelter();
  Future<int> likesPet(int idmascota);
  Future<List<Pet>> favoritePets();
  Future<dynamic> updateInfoUser(Map<String , dynamic> data);
  Future<AdoptionRequest> sendAdoptRequest(Map<String, dynamic> data);
  Future<int> signature(Uint8List signatureImage);
  Future<EvidenceResponse> verifyResidenceEvidence();
  Future<bool> uploadResidenceEvidence(List<String> images);
   Future<bool>uploadDocumentEvidence(List<String> images);
  Future<bool> registerContactHour(String data);
  Future<Map<String,dynamic>> getContactHour();
  Future<bool> updateContactHour(String data);
  Future<bool> registerIncidence(Map<String , dynamic> data);
  Future<List<Incidencia>> listIncidences(int idPet);
  Future<List<PetU>> listPetsOrganizationByUser();
  Future<String> getPetProfileImage(int idPet);
  Future<List<PetOrgRequest>> findPetsWithRequest();
  Future<List<Solicitude>> findUserRequest();
  Future<List<RequestPet>> requestByPet(int idPet);
  Future<Solicitud> changeStatusRequest(int idSolicitud,int newStatus);
  Future<dynamic> sendPDFContract(String organitationName,String adopter,String additionalClause);
  Future<String> getShelterName();
  Future<dynamic> createAdoption(Map<String,dynamic> data);
  Future<List<Seguimiento>> getSeguimientosByuser();

}
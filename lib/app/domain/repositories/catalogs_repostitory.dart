
import '../models/index.dart';
import '../models/parentesco_item.dart';

abstract class CatalogsRepository{

  Future<List<Ocupation>> get ocupations;
  Future<List<CivilState>> get civilState;
  Future<List<Sex>> get sex;
  Future<List<Residence>> get residence;
  Future<List<NivelActividad>> get activityLevels;
  Future<List<PetType>> get petType;
  Future<List<RazaType>> get razas;
  Future <List <CaracteristicasType> > get caracteristicas;

  Future<List<PetAgeResponse>> get petEdad;
  Future<List<ParentescoItem>> get parentescos;



}
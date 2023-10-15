import 'package:get/get.dart';
import 'package:pachitaapp/app/presentation/modules/home/home_view.dart';
import 'package:pachitaapp/app/presentation/modules/pet/pet_gallery.dart';
import 'package:pachitaapp/app/presentation/modules/pet/pet_profile.dart';
import 'package:pachitaapp/app/presentation/modules/pet/pet_week.dart';
import 'package:pachitaapp/app/presentation/modules/pet/pets_view.dart';
import 'package:pachitaapp/app/presentation/modules/petition/controllers/petition_binding.dart';
import 'package:pachitaapp/app/presentation/modules/petition/widgets/advice.dart';
import 'package:pachitaapp/app/presentation/modules/register/account_view.dart';
import 'package:pachitaapp/app/presentation/modules/user/new_view.dart';
import 'package:pachitaapp/app/presentation/modules/user/reference_view.dart';
import 'package:pachitaapp/app/presentation/modules/user/user_view.dart';
import '../modules/home/controllers/home_binding.dart';
import '../modules/home/final_photo_view.dart';
import '../modules/home/search_view.dart';
import '../modules/home/seguimiento_view.dart';
import '../modules/home/user_motives_view.dart';
import '../modules/login/controllers/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/pet/controllers/pet_binding.dart';
import '../modules/pet/pet_request_view.dart';
import '../modules/pet/pre_view.dart';
import '../modules/pet/spend_view.dart';
import '../modules/pet/widgets/error_view.dart';
import '../modules/petition/petition_view.dart';
import '../modules/privacy/privacy_view.dart';
import '../modules/register/about_view.dart';
import '../modules/register/controller/register_binding.dart';
import '../modules/user/aditional_view.dart';
import '../modules/user/candidate_view.dart';
import '../modules/user/contact_view.dart';
import '../modules/user/controllers/shelter_binding.dart';
import '../modules/user/create_org.dart';
import '../modules/user/documents_view.dart';
import '../modules/user/edit_view.dart';
import '../modules/user/end_view.dart';
import '../modules/user/incidence_view.dart';
import '../modules/user/previus_view.dart';
import '../modules/user/requeriments_view.dart';
import '../modules/user/request_list_view.dart';
import '../modules/user/residence_view.dart';
import '../modules/user/shelter_view.dart';
import '../modules/splash/controllers/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/started/started_view.dart';
import '../modules/user/signature_view.dart';
import '../modules/user/task_view.dart';
import 'routes.dart';

final pages = [
  GetPage(
    name: Routes.splash,
    page: () => SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(name: Routes.start, page: () => const StartedView()),
  GetPage(
      name: Routes.home, page: () => const HomeView(), binding: HomeBinding()),
  GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding()),
  GetPage(
      name: Routes.register,
      page: () => const AboutView(),
      binding: RegisterBinding()),
  GetPage(
      name: Routes.account,
      page: () => const AccountView(),
      binding: RegisterBinding()),
  GetPage(name: Routes.petsList, page: () => PetsView(), binding: PetBinding()),
  GetPage(name: Routes.petOfWeek, page: () => PetWeek(), binding: PetBinding()),
  GetPage(
      name: Routes.petProfile, page: () => PetProfile(), binding: PetBinding()),
  GetPage(
      name: Routes.petGallery, page: () => PetGallery(), binding: PetBinding()),
  GetPage(
      name: Routes.shelter,
      page: () => ShelterView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.newPet, page: () => NewView(), binding: ShelterBinding()),
  GetPage(
      name: Routes.userProfile,
      page: () => UserView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.residenceEvidence,
      page: () => ResidenceView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.documentsEvidence,
      page: () => DocumentsView(),
      binding: ShelterBinding()),

  GetPage(
      name: Routes.previusPets,
      page: () => PreviusView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.contactHours,
      page: () => ContactView(),
      binding: ShelterBinding()),
  GetPage(name: Routes.prePeticion, page: () => const Advice()),
  GetPage(
      name: Routes.peticion,
      page: () => const PetitionView(),
      binding: PetitionBinding()),
  GetPage(
      name: Routes.newPetPhotos,
      page: () => AditionalView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.createOrg,
      page: () => const CreateOrg(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.editProfile,
      page: () => EditView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.creaRecordatorio,
      page: () => const TaskView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.adoptProfile,
      page: () => RequerimentsView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.razonesAdopt,
      page: () => PreView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.referencias,
      page: () => const ReferenceView(),
      binding: PetBinding()),
  GetPage(
      name: Routes.errorAdopt,
      page: () => const ErrorView(),
      binding: PetBinding()),
  GetPage(
      name: Routes.signature,
      page: () => const SignatureView(),
      binding: PetBinding()),
  GetPage(
      name: Routes.incidence,
      page: () => IncidenceView(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.searchIncidence,
      page: () => SearchView(),
      binding: HomeBinding()),

  //petRequestList
  GetPage(
      name: Routes.petRequestList,
      page: () => PetRequestView(),
      binding: PetBinding()),
  GetPage(
      name: Routes.historial, page: () => SpendView(), binding: PetBinding()),
  GetPage(
      name: Routes.requestList,
      page: () => RequestListview(),
      binding: ShelterBinding()),
  GetPage(
      name: Routes.privacy,
      page: () => const PrivacyPolicyView(),
      binding: ShelterBinding()),

  GetPage(
      name: Routes.candidateView,
      page: () => CandidateView(),
      binding: ShelterBinding()),

        GetPage(
      name: Routes.candidateMotives,
      page: () => UserMotivesView(),
      binding: HomeBinding()),

      GetPage(
      name: Routes.endView,
      page: () => EndView(),
      binding: ShelterBinding()),

           GetPage(
      name: Routes.seguimientoView,
      page: () => SeguimientoView(),
      binding: HomeBinding()),

           GetPage(
      name: Routes.finalPhoto,
      page: () => FinalPhotoView(),
      binding: HomeBinding()),
];

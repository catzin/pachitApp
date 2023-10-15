import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import '../../global_controllers/global_controller.dart';
import '../../theme/colors.dart';
import 'controllers/home_controller.dart';
import 'favorite_view.dart';
import 'widgets/flow.dart';
import 'request_view.dart';
import 'widgets/home_content.dart';
import 'widgets/side_nav.dart';



class HomeView extends StatefulWidget {
   const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();


}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  Widget _currentScreen = HomeContent();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final globalController = Get.find<GlobalController>();

    switch (_currentIndex) {
      case 0:
        _currentScreen = HomeContent();
        break;
      case 1:
        _currentScreen = FavoriteView();
        break;
      case 2:
        _currentScreen = RequestView();
        break;
    
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/app/presentation/assets/slogan.png'),
        backgroundColor: HexColor(AppColors.primaryOrange),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: HexColor(AppColors.primaryOrange),
                iconSize: 40,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  LineIcons.paw,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0, bottom: 0),
            child: InkWell(
              onTap: () => Get.toNamed(Routes.userProfile),
              child: Obx(
                () => homeController.readyPicture.value
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        backgroundImage: CachedNetworkImageProvider(
                            homeController.avatar.value))
                    : const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: HexColor(AppColors.primaryGray),
          borderRadius: const BorderRadius.only(topLeft:Radius.circular(12), topRight:Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child:  SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: GNav(
            rippleColor:HexColor(AppColors.secondaryLight),
            hoverColor:HexColor(AppColors.primaryGray),
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: HexColor(AppColors.primaryOrange),

            onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            
            tabs: const [
              GButton(icon: LineIcons.home, text: 'Home',),
              GButton(icon: LineIcons.heart, text: 'Favoritos',),
              GButton(icon: LineIcons.envelope, text: 'Solicitudes',),
          
            ],
          ),
        ),
        ),
      ),
      drawer: SideNav(homeController: homeController),
      body: _currentScreen,
      floatingActionButton: Obx(
        () => globalController.isShelter.value == false
            ? Container()
            : CustomDial(),
      ),
    );
  }
}



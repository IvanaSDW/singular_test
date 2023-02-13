import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singular_test/ui/pages/home/favorites/favorites_logic.dart';
import 'package:singular_test/ui/pages/home/gallery/gallery_logic.dart';
import 'package:singular_test/ui/pages/home/gallery/gallery_view.dart';
import '../../../controllers/home_logic.dart';
import 'favorites/favorites_view.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  final galleryController = Get.find<GalleryLogic>();
  final favoritesController = Get.find<FavoritesLogic>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Center(child: Text('Singular Design')),
          title: Text(
            logic.currentTab == 0
                ? logic.galleryTitle.value
                : logic.favoritesTitle.value,
          ),
          actions: logic.currentTab == 0
              ? [
                  galleryController.keyword.isEmpty
                      ? IconButton(
                          onPressed: galleryController.showSearchBar
                              ? null
                              : () {
                                  galleryController.showSearchBar = true;
                                },
                          icon: Icon(
                            Icons.search,
                            color: galleryController.showSearchBar
                                ? Colors.transparent
                                : Colors.white,
                          ))
                      : TextButton(
                          onPressed: () {
                            galleryController.showSearchBar = false;
                            galleryController.refreshGallery();
                          },
                          child: const Center(
                            child: Text(
                              'Clear\nsearch',
                              maxLines: 2,
                              style: TextStyle(color: Colors.red),
                            ),
                          )),
                ]
              : [
                  favoritesController.keyword.isEmpty
                      ? IconButton(
                          onPressed: favoritesController.showSearchBar
                              ? null
                              : () {
                                  favoritesController.showSearchBar = true;
                                },
                          icon: Icon(
                            Icons.search,
                            color: favoritesController.showSearchBar
                                ? Colors.transparent
                                : Colors.white,
                          ))
                      : TextButton(
                          onPressed: () {
                            favoritesController.showSearchBar = false;
                            favoritesController.refreshGallery();
                          },
                          child: const Center(
                            child: Text(
                              'Clear\nsearch',
                              maxLines: 2,
                              style: TextStyle(color: Colors.red),
                            ),
                          )),
                ],
        ),
        body: logic.currentTab == 0 ? GalleryWidget() : FavoritesWidget(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          backgroundColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
                label: 'Browse Images', icon: Icon(Icons.collections)),
            BottomNavigationBarItem(
                label: 'My favorites', icon: Icon(Icons.favorite))
          ],
          unselectedItemColor: Colors.white.withOpacity(0.6),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          currentIndex: logic.currentTab,
          onTap: (index) => logic.currentTab = index,
        ),
      );
    });
  }
}

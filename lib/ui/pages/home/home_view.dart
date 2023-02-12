import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singular_test/ui/pages/home/gallery/gallery_logic.dart';
import 'package:singular_test/ui/pages/home/gallery/gallery_view.dart';
import '../../../controllers/home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  final galleryController = Get.find<GalleryLogic>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Center(child: Text('Singular Design')),
        title: Obx(() {
          return Text(
            logic.homeTitle.value,
          );
        }),
        actions: [
          Obx(() {
            return galleryController.keyword.isEmpty
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
                    ));
          }),
        ],
      ),
      body: Obx(() {
        return logic.currentTab == 0 ? GalleryComponent() : Container();
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
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
        );
      }),
    );
  }
}

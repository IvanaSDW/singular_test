import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:singular_test/ui/widgets/favorite_image_tile.dart';
import 'favorites_logic.dart';

class FavoritesWidget extends StatelessWidget {
  final logic = Get.find<FavoritesLogic>();

  FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return logic.currentImages.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 8.0),
                  child: logic.showSearchBar
                      ? Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Search...',
                                  ),
                                  onChanged: (String input) =>
                                      logic.keyword = input,
                                  onSubmitted: (String keyword) {
                                    () => logic.submitSearch();
                                  }),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.send,
                                size: 36,
                              ),
                              color: Colors.blue,
                              disabledColor: Colors.grey,
                              onPressed: logic.keyword.isEmpty
                                  ? null
                                  : () => logic.submitSearch(),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () => logic.showSearchBar = false,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white24),
                                onPressed: () {
                                  logic.loadFavImages();
                                },
                                child: const Icon(Icons.arrow_back)),
                            const SizedBox(
                              width: 24,
                            ),
                            const Text(
                              'Page',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            FilledButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white24),
                                onPressed: () {
                                  logic.loadFavImages();
                                },
                                child: const Icon(Icons.arrow_forward)),
                          ],
                        ),
                ),
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: () => logic.refreshGallery(),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: logic.currentImages.length,
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 16.0, right: 16.0, bottom: 0.0),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(
                          future: logic.loadImage(index),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? FavoriteImageTile(image: snapshot.data!)
                                : const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: SizedBox(
                width: Get.width * 0.8,
                child: const Card(
                  color: Colors.black26,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'You have not yet added images to your collection.\nBrowse to Gallery tab and start adding your favorites!!!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
    });
  }
}

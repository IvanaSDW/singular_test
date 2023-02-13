import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singular_test/models/unsplash_image.dart';
import '../pages/home/favorites/favorites_logic.dart';

class FavoriteImageTile extends StatelessWidget {
  FavoriteImageTile({key, required this.image}) : super(key: key);
  final UnsplashImage image;
  final FavoritesLogic favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: GridTile(
        child: Column(
          children: [
            InkWell(
              onTap: () => favoritesController.onImageTapped(image.id),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: image.regularUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white),
              width: double.maxFinite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: image.author.avatarMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(child: Text(image.author.userName)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => favoritesController.onRemoveImageFromUserCollection(image.id),
                          child: const Text(
                            'Remove from\n my collection',
                            style: TextStyle(fontSize: 10),
                          )),
                      Expanded(
                        child: Container(),
                      ),
                      const Icon(Icons.favorite_border),
                      Text(
                        '${image.likes}',
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

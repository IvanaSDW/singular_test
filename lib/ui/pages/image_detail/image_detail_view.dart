import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:singular_test/models/unsplash_image.dart';
import 'package:singular_test/utils/constants.dart';

import 'image_detail_logic.dart';

class ImageDetailPage extends StatelessWidget {
  final logic = Get.find<ImageDetailLogic>();
  String? imageId;

  ImageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    imageId = Get.arguments['imageId'];
    if (imageId == null) {
      Get.back();
    }
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<UnsplashImage?>(
            future: logic.loadImageFromUnsplash(imageId!),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('No data loaded for that image'),
                  );
                }
                UnsplashImage image = snapshot.data!;
                return SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: const [Text('by:')],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(radius: 30,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: image.author.avatarLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(child: Text(image.author.userName)),
                          TextButton(onPressed: (){},
                              child: const Text('more...')
                          )
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Text('"${image.description}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                      CachedNetworkImage(imageUrl: image.fullUrl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.remove_red_eye_outlined),
                              Text(' ${image.views}'),
                            ],
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.favorite_border),
                              Text(' ${image.likes}'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(child: Text('Featured in: ${image.topics.toString()}')),
                        ],
                      )
                    ],
                  ),
                );
              }
              else {
                return const SpinKitChasingDots(color: Colors.blue,);
              }
            }
          ),
        ),
      ),
    );
  }
}

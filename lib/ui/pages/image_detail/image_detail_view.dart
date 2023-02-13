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
  String? source;

  ImageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    imageId = Get.arguments['imageId'];
    source = Get.arguments['source'] ?? 'unsplash';
    logger.i('args: imageid = $imageId, source = $source');
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
              future: source == 'local'
                  ? logic.loadImageFromFirebase(imageId!)
                  : logic.loadImageFromUnsplash(imageId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitChasingDots(
                    color: Colors.blue,
                  );
                }
                if (snapshot.error != null) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
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
                            CircleAvatar(
                              radius: 30,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: image.author.avatarLarge,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Text(
                              image.author.userName,
                              style: const TextStyle(fontSize: 18),
                            )),
                            source == 'local'
                                ? const SizedBox.shrink()
                                : TextButton(
                                    onPressed: () =>
                                        logic.onMoreAboutAuthorTapped(
                                            image.author.userName),
                                    child: const Text('more...'))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          image.description == null
                              ? ''
                              : '"${image.description}"',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () =>
                                logic.onAddImageToUserCollection(image),
                            child: const Text(
                              'Add to my collection',
                              style: TextStyle(fontSize: 10),
                            )),
                        CachedNetworkImage(imageUrl: image.fullUrl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            image.views == null
                                ? const SizedBox.shrink()
                                : Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                            Flexible(
                                child: Text(
                                    'Featured in: ${image.topics.toString()}')),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return const SpinKitChasingDots(
                    color: Colors.blue,
                  );
                }
              }),
        ),
      ),
    );
  }
}

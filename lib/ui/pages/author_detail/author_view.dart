import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:singular_test/models/unsplash_user.dart';
import 'package:singular_test/utils/constants.dart';

import 'author_view_logic.dart';

class AuthorDetailPage extends StatelessWidget {
  final logic = Get.find<AuthorDetailLogic>();

  String? authorName;

  @override
  Widget build(BuildContext context) {
    authorName = Get.arguments['authorName'];
    if (authorName == null) {
      Get.back();
    }
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<UnsplashUser?>(
              future: logic.loadUserFromUnsplash(authorName!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('No data loaded for that user'),
                    );
                  }
                  UnsplashUser author = snapshot.data!;
                  return SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: author.avatarLarge,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${author.firstName} ${author.lastName}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '@${author.userName}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            textAlign: TextAlign.center,
                            author.bio == null ? '-.-' : '"${author.bio}"',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                          const Icon(Icons.location_on_outlined),
                          Text(' ${author.location}'),
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

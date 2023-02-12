import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:singular_test/models/unsplash_image.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({key, required this.image}) : super(key: key);
  final UnsplashImage image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Hero(
        tag: image.id,
        child: GridTile(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: image.regularUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: Colors.white),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: image.user.avatarMedium,
                      ),
                    ),
                    Text(image.user.userName),
                    const Icon(Icons.favorite_border),
                    Text('${image.likes}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

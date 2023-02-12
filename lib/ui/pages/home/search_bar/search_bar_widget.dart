import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import 'search_bar_controller.dart';

class SearchBarWidget extends StatelessWidget {

  const SearchBarWidget({super.key, required this.controller});

  final SearchBarController controller;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (String input) => controller.keyword = input,
              onSubmitted: (String keyword) {
                logger.i('keyword typed: $keyword');
                controller.onSubmitSearch();
              }),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => controller.onSubmitSearch(),
        ),
      ],
    );
  }
}

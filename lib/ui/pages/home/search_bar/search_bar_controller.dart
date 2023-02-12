import 'package:get/get.dart';

class SearchBarController extends GetxController {

  Function onSubmit;

  SearchBarController({required this.onSubmit});

  final Rx<String> _keyword = ''.obs;
  String get keyword => _keyword.value;
  set keyword(String value) => _keyword.value = value;

  onSubmitSearch() => onSubmit(keyword);

}

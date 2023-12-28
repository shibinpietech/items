import 'package:get/get.dart';
import 'package:items/core/api_provider.dart';

class CategoryController extends GetxController {
  final ApiService _apiService = ApiService();
  final categories = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final result = await _apiService.fetchData('categories');
      categories.assignAll(result);
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }
}

import 'package:get/get.dart';
import 'package:items/core/api_provider.dart';
import 'package:items/models/products_model.dart';

class ProductsController extends GetxController {
  final ApiService _apiService = ApiService();
  var products = <dynamic>[].obs;

  Future<void> fetchProducts(String title) async {
    try {
      final result = await _apiService.fetchProducts('category/$title');
      products.value = result.products;
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }
}

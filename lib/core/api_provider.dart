import 'package:dio/dio.dart';
import 'package:items/models/products_model.dart';

class ApiService {
  final Dio _dio = Dio();
  String baseUrl = 'https://dummyjson.com/products/';

  Future<List<dynamic>> fetchData(String endPoint) async {
    try {
      final response = await _dio.get(baseUrl + endPoint);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server: $error');
    }
  }

  Future<Products> fetchProducts(String endPoint) async {
    try {
      final response = await _dio.get(baseUrl + endPoint);
      if (response.statusCode == 200) {
        return Products.fromJson(response.data);
      } else {
        throw Exception('Failed to load smartphones');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server: $error');
    }
  }
}

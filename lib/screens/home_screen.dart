import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:items/screens/products_screen.dart';
import 'package:items/utils/category_controller.dart';

class CategoriesPage extends StatelessWidget {
  final CategoryController _controller = Get.put(CategoryController());

  CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Obx(
        () => _controller.categories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _controller.categories.length,
                itemBuilder: (context, index) {
                  final category = _controller.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(ProductsScreen(
                        title: category,
                      ));
                    },
                    child: ListTile(
                      title: Text(category),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: CategoriesPage(),
  ));
}

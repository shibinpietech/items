import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:items/models/products_model.dart';
import 'package:items/screens/selected_items_screen.dart';
import 'package:items/utils/products_controller.dart';

class ProductsScreen extends StatefulWidget {
  final String title;

  const ProductsScreen({super.key, required this.title});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsController _controller = Get.put(ProductsController());
  List<Product> selectedProducts = [];

  @override
  void initState() {
    _controller.fetchProducts(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: selectedProducts.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                Get.to(
                    SelectedProductsScreen(selectedProducts: selectedProducts));
                print("Selected Products: $selectedProducts");
              },
              child: const Icon(Icons.trolley),
            )
          : null, // Set to null if no products are selected
      body: Obx(
        () {
          if (_controller.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildGridView(_controller.products);
          }
        },
      ),
    );
  }

  Widget buildGridView(List<dynamic> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        bool isSelected = selectedProducts.contains(product);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedProducts.remove(product);
              } else {
                selectedProducts.add(product);
              }
            });
          },
          child: buildProductItem(product, isSelected),
        );
      },
    );
  }

  Widget buildProductItem(Product product, bool isSelected) {
    return Container(
      color: isSelected ? Colors.blue.withOpacity(0.5) : null,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Opacity(
              opacity: isSelected ? 0.5 : 1.0,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(product.title),
        ],
      ),
    );
  }
}

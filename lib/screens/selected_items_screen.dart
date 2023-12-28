import 'package:flutter/material.dart';
import 'package:items/models/products_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class SelectedProductsScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  const SelectedProductsScreen({super.key, required this.selectedProducts});

  @override
  _SelectedProductsScreenState createState() => _SelectedProductsScreenState();
}

class _SelectedProductsScreenState extends State<SelectedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Products'),
      ),
      body: widget.selectedProducts.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ReorderableGridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: widget.selectedProducts
                    .map((e) => buildProductItem(e))
                    .toList(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    final element = widget.selectedProducts.removeAt(oldIndex);
                    widget.selectedProducts.insert(newIndex, element);
                  });
                },
              ),
            )
          : const Center(
              child: Text('No selected products'),
            ),
    );
  }

  Widget buildProductItem(Product product) {
    return Card(
      key: ValueKey(product),
      child: Column(
        children: [
          SizedBox(height: 130, child: buildZoomableImage(product.thumbnail)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildZoomableImage(String imageUrl) {
    return ClipRRect(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(),
            ),
          ));
        },
        child: Hero(
          tag: imageUrl,
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}

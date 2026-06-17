import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;
  UpdateProductPage({super.key, required this.product});
  @override
  State<UpdateProductPage> createState() {
    // TODO: implement createState
    return UpdateProductState(product: product);
  }
}

class UpdateProductState extends State<UpdateProductPage> {
  String? _nameProduct;
  double? _price;
  String? _category;
  String _selectedCategory = "Laptop văn phòng";
  final Product product;
  UpdateProductState({required this.product});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Chinh sua san pham",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ten san pham"),
            TextField(
              decoration: InputDecoration(
                hintText: product.name,
                hintTextDirection: TextDirection.ltr,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                _nameProduct = value;
              },
            ),
            SizedBox(height: 8),
            const Text("Gia san pham"),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: product.price.toString(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                _price = double.tryParse(value) ?? product.price;
              },
            ),
            SizedBox(height: 8),
            const Text("Loai san pham"),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: <String>["Laptop Gaming", "Laptop văn phòng"].map((
                      location,
                    ) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      14,
                    ), // Bo góc đồng bộ với ô nhập
                  ),
                ),
                onPressed: () {
                  context.read<ProductCubit>().updateCurrentProduct(
                    Product(
                      id: product.id,
                      name: _nameProduct ?? product.name,
                      price: _price ?? product.price,
                      category: _category ?? product.category,
                    ),
                  );
                  Navigator.pop(context, "Đã chỉnh sửa thành công");
                },
                child: const Text("Sua du lieu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

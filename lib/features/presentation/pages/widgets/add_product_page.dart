import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() {
    // TODO: implement createState
    return AddProductState();
  }
}

class AddProductState extends State<AddProductPage> {
  String? _nameProduct;
  double? _price;
  String? _category;
  String _selectedCategory = "Laptop văn phòng";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Them san pham",
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
                hintText: "Nhap ten san pham",
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
                hintText: "Nhap gia san pham",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                _price = double.tryParse(value) ?? 1;
              },
            ),
            SizedBox(height: 8),
            const Text("Loai san pham"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
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
                  context.read<ProductCubit>().addNewProduct(
                    Product(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: _nameProduct ?? "Unknown",
                      price: _price ?? 0,
                      category: _category ?? _selectedCategory,
                    ),
                  );

                  Navigator.pop(context, "Thêm sản phẩm thành công");
                },
                child: const Text("Thêm sản phẩm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

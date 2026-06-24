import 'package:prjbloc/features/data/models/product_model.dart';
import 'package:prjbloc/features/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsData({String? query});
  Future<void> addProductData(Product product);
  Future<void> updateProductData(Product product);
  Future<void> deleteProductData(String id);
  Future<List<ProductModel>> filterByCategory({String? category});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final List<ProductModel> _arrProduct = [
    ProductModel(
      id: "SP01",
      name: "Acer Nitro v15",
      price: 20000000,
      category: "Laptop Gaming",
    ),
    ProductModel(
      id: "SP02",
      name: "Dell inspiron 3437",
      price: 5000000,
      category: "Laptop văn phòng",
    ),
  ];
  @override
  Future<void> addProductData(Product product) async {
    await Future.delayed(Duration(seconds: 2));
    _arrProduct.add(
      ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: product.name,
        price: product.price,
        category: product.category,
      ),
    );
  }

  @override
  Future<void> deleteProductData(String id) async {
    await Future.delayed(Duration(seconds: 2));
    final index = _arrProduct.indexWhere((product) => product.id == id);
    if (index != -1) {
      _arrProduct.removeAt(index);
    }
  }

  @override
  Future<List<ProductModel>> filterByCategory({String? category}) async {
    // TODO: implement filterByCategory
    await Future.delayed(Duration(seconds: 1));
    List<ProductModel> result = List.from(_arrProduct);
    if (category == "Tất cả") {
      return result;
    }
    if (category != null && category.isNotEmpty) {
      result = result.where((p) => p.category == category).toList();
    }
    return result;
  }

  @override
  Future<List<ProductModel>> getProductsData({String? query}) async {
    // TODO: implement getProductsData
    await Future.delayed(Duration(seconds: 2));
    List<ProductModel> result = List.from(_arrProduct);
    if (query != null && query.isNotEmpty) {
      result = result
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return result;
  }

  @override
  Future<void> updateProductData(Product product) async {
    await Future.delayed(Duration(seconds: 2));
    final index = _arrProduct.indexWhere((data) => data.id == product.id);
    if (index != -1) {
      _arrProduct[index] = ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        category: product.category,
      );
    } else {
      throw Exception("Khong san pham nao nhu the ca");
    }
  }
}

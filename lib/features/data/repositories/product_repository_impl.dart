import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final List<Product> _arrProduct = [
    Product(
      id: "SP01",
      name: "Acer Nitro v15",
      price: 20000000,
      category: "Laptop Gaming",
    ),
    Product(
      id: "SP02",
      name: "Dell inspiron 3437",
      price: 5000000,
      category: "Laptop văn phòng",
    ),
  ];
  @override
  Future<List<Product>> getProductsData({String? query}) async {
    await Future.delayed(Duration(seconds: 2));
    List<Product> result = List.from(_arrProduct);
    if (query != null && query.isNotEmpty) {
      result = result
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return result;
  }

  @override
  Future<void> addProductData(Product product) async {
    // TODO: implement addProductData
    _arrProduct.add(product);
  }

  @override
  Future<void> deleteProductData(String id) async {
    // TODO: implement deleteProductData
    final index = _arrProduct.indexWhere((product) => product.id == id);
    if (index != -1) {
      _arrProduct.removeAt(index);
    }
  }

  @override
  Future<void> updateProductData(Product product) async {
    // TODO: implement updateProductData
    final index = _arrProduct.indexWhere((data) => data.id == product.id);
    if (index != -1) {
      _arrProduct[index] = product;
    } else {
      throw Exception("Khong san pham nao nhu the ca");
    }
  }

  @override
  Future<List<Product>> filterByCategory({String? category}) async {
    // TODO: implement filterByCategory
    List<Product> result = List.from(_arrProduct);
    if (category == "Tất cả") {
      return result;
    }
    if (category != null && category.isNotEmpty) {
      result = result.where((p) => p.category == category).toList();
    }
    return result;
  }
}

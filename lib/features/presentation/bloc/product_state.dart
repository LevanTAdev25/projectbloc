import 'package:prjbloc/features/domain/entities/product.dart';

sealed class ProductState {}

class ProductInitialize extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Product> listProducts;
  ProductLoadSuccess(this.listProducts);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

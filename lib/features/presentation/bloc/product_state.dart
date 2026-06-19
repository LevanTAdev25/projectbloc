import 'package:prjbloc/features/domain/entities/product.dart';

sealed class ProductState {}

class ProductInitialize extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Product> listProducts;
  final String selectedCategory;
  final String query;
  ProductLoadSuccess(this.listProducts, {this.selectedCategory = "Tất cả", this.query = ""});
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductFormState extends ProductState {
  final String name;
  final double price;
  final String category;
  final String? editingProductId;

  ProductFormState({
    required this.name,
    required this.price,
    required this.category,
    this.editingProductId,
  });

  ProductFormState copyWith({
    String? name,
    double? price,
    String? category,
    String? editingProductId,
    bool clearEditingId = false,
  }) {
    return ProductFormState(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      editingProductId: clearEditingId ? null : (editingProductId ?? this.editingProductId),
    );
  }
}

class ProductActionSuccess extends ProductState {
  final String message;
  ProductActionSuccess(this.message);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/domain/entities/product.dart';
import 'package:prjbloc/features/domain/usecases/add_product.dart';
import 'package:prjbloc/features/domain/usecases/filter_by_category.dart';
import 'package:prjbloc/features/domain/usecases/get_product_list.dart';
import 'package:prjbloc/features/domain/usecases/remove_product.dart';
import 'package:prjbloc/features/domain/usecases/update_product.dart';
import 'package:prjbloc/features/presentation/bloc/product_state.dart';
import 'package:prjbloc/features/presentation/pages/widgets/update_product_page.dart';
import 'package:prjbloc/features/presentation/pages/widgets/add_product_page.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductList _getProductList;
  final AddProduct _addProduct;
  final RemoveProduct _removeProduct;
  final UpdateProduct _updateProduct;
  final FilterByCategory _filterByCategory;

  ProductCubit({
    required this._getProductList,
    required this._addProduct,
    required this._removeProduct,
    required this._updateProduct,
    required this._filterByCategory,
  }) : super(ProductInitialize());
  Future<void> loadProducts({String? query, String? category}) async {
    emit(ProductLoading());
    try {
      List<Product> arrProduct = await _getProductList(query: query);
      emit(
        ProductLoadSuccess(
          arrProduct,
          selectedCategory: category ?? "Tất cả",
          query: query ?? "",
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> addNewProduct(Product product) async {
    try {
      await _addProduct(product: product);

      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> removeCurrentProduct(String id) async {
    try {
      await _removeProduct(id: id);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> updateCurrentProduct(Product product) async {
    try {
      await _updateProduct(product: product);
      await loadProducts();
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> newProductListByCategory(String? category) async {
    emit(ProductLoading());
    try {
      final newListProduct = await _filterByCategory(category: category);
      emit(
        ProductLoadSuccess(
          newListProduct,
          selectedCategory: category ?? "Tất cả",
          query: "",
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  void initCreateForm() {
    emit(
      ProductFormState(
        name: '',
        price: 0.0,
        category: 'Laptop văn phòng',
        editingProductId: null,
      ),
    );
  }

  void initEditForm(Product product) {
    emit(
      ProductFormState(
        name: product.name,
        price: product.price,
        category: product.category,
        editingProductId: product.id,
      ),
    );
  }

  void updateFormName(String name) {
    if (state is ProductFormState) {
      emit((state as ProductFormState).copyWith(name: name));
    }
  }

  void updateFormPrice(String priceStr) {
    if (state is ProductFormState) {
      final price = double.tryParse(priceStr) ?? 0.0;
      emit((state as ProductFormState).copyWith(price: price));
    }
  }

  void updateFormCategory(String category) {
    if (state is ProductFormState) {
      emit((state as ProductFormState).copyWith(category: category));
    }
  }

  Future<void> submitCreateForm() async {
    if (state is! ProductFormState) return;
    final formState = state as ProductFormState;
    final product = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: formState.name,
      price: formState.price,
      category: formState.category,
    );
    try {
      await addNewProduct(product);
      emit(ProductActionSuccess("Thêm sản phẩm thành công"));
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
      emit(formState);
    }
  }

  Future<void> submitEditForm() async {
    if (state is! ProductFormState) return;
    final formState = state as ProductFormState;
    if (formState.editingProductId == null) return;

    final product = Product(
      id: formState.editingProductId!,
      name: formState.name,
      price: formState.price,
      category: formState.category,
    );
    try {
      await updateCurrentProduct(product);
      emit(ProductActionSuccess("Đã chỉnh sửa thành công"));
    } catch (e) {
      emit(ProductError(e.toString().replaceAll("Exception: ", "")));
      emit(formState);
    }
  }

  Future<void> snackBarPopUpdate(
    BuildContext parentContext,
    Product product,
  ) async {
    parentContext.read<ProductCubit>().initEditForm(product);
    final result = await Navigator.push(
      parentContext,
      MaterialPageRoute(builder: (context) => UpdateProductPage()),
    );
    if (!parentContext.mounted) {
      return;
    }
    if (result != null) {
      ScaffoldMessenger.of(parentContext)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
    }
  }

  Future<void> snackBarPopAdd(BuildContext context) async {
    context.read<ProductCubit>().initCreateForm();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
    if (!context.mounted) {
      return;
    }
    if (result != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}

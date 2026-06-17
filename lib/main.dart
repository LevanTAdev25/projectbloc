import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/data/repositories/product_repository_impl.dart';
import 'package:prjbloc/features/domain/usecases/add_product.dart';
import 'package:prjbloc/features/domain/usecases/filter_by_category.dart';
import 'package:prjbloc/features/domain/usecases/get_product_list.dart';
import 'package:prjbloc/features/domain/usecases/remove_product.dart';
import 'package:prjbloc/features/domain/usecases/update_product.dart';
import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';
import 'package:prjbloc/features/presentation/pages/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final productRepository = ProductRepositoryImpl();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepositoryImpl();
    final getProductsUseCase = GetProductList(productRepository);
    final addProductUseCase = AddProduct(productRepository);
    final updateProductUseCase = UpdateProduct(productRepository);
    final deleteProductUseCase = RemoveProduct(productRepository);
    final filterByCategory = FilterByCategory(productRepository);

    return BlocProvider(
      create: (context) => ProductCubit(
        getProductList: getProductsUseCase,
        addProduct: addProductUseCase,
        updateProduct: updateProductUseCase,
        removeProduct: deleteProductUseCase,
        filterByCategory: filterByCategory,
      )..loadProducts(),
      child: MaterialApp(home: ProductListPage()),
    );
  }
}

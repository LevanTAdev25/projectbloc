import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';
import 'package:prjbloc/features/presentation/bloc/product_state.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (previous, current) => current is ProductError,
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Danh sach san pham")),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    context.read<ProductCubit>().loadProducts(query: value);
                  },
                ),
              ),

              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    current is ProductLoadSuccess ||
                    current is ProductLoading ||
                    current is ProductError,
                builder: (context, state) {
                  String selectedCategory = "Tất cả";
                  if (state is ProductLoadSuccess) {
                    selectedCategory = state.selectedCategory;
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        items:
                            <String>[
                              "Tất cả",
                              "Laptop Gaming",
                              "Laptop văn phòng",
                            ].map((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                        onChanged: (value) {
                          context.read<ProductCubit>().newProductListByCategory(
                            value,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) =>
                      current is ProductLoadSuccess ||
                      current is ProductLoading ||
                      current is ProductError,
                  builder: (blocContext, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductLoadSuccess) {
                      final listProduct = state.listProducts;
                      return ListView.builder(
                        itemCount: listProduct.length,
                        itemBuilder: (itemContext, index) {
                          final product = listProduct[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${product.price}\$ - ${product.category}",
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      blocContext
                                          .read<ProductCubit>()
                                          .removeCurrentProduct(product.id);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      blocContext
                                          .read<ProductCubit>()
                                          .snackBarPopUpdate(context, product);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text("Bat dau tai du lieu"));
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>
                context.read<ProductCubit>().snackBarPopAdd(context),
            label: const Text("Thêm"),
            icon: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prjbloc/features/data/variable/key_form.dart';
import 'package:prjbloc/features/presentation/bloc/product_cubit.dart';
import 'package:prjbloc/features/presentation/bloc/product_state.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    final formState = cubit.state as ProductFormState;

    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (previous, current) =>
          current is ProductActionSuccess || current is ProductError,
      listener: (context, state) {
        if (state is ProductActionSuccess) {
          Navigator.pop(context, state.message);
        } else if (state is ProductError) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
          child: Form(
            key: addProductKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ten san pham"),
                TextFormField(
                  initialValue: formState.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tên sản phẩm không được để trống";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Nhap ten san pham",
                    hintTextDirection: TextDirection.ltr,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.updateFormName(value);
                  },
                ),
                const SizedBox(height: 8),
                const Text("Gia san pham"),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  initialValue: formState.price > 0
                      ? formState.price.toString()
                      : "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Giá sản phẩm không được để trống";
                    }
                    if (double.tryParse(value) == null) {
                      return "Định dạng giá tiền không đúng";
                    }
                    if (double.tryParse(value) != null &&
                        double.parse(value) <= 0) {
                      return "Giá sản phẩm phải lớn hơn 0";
                    }
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Nhap gia san pham",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.updateFormPrice(value);
                  },
                ),
                const SizedBox(height: 8),
                const Text("Loai san pham"),
                Container(
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
                    child: BlocBuilder<ProductCubit, ProductState>(
                      buildWhen: (previous, current) =>
                          current is ProductFormState,
                      builder: (context, state) {
                        final currentCategory = (state is ProductFormState)
                            ? state.category
                            : formState.category;
                        return DropdownButton<String>(
                          value: currentCategory,
                          isExpanded: true,
                          items: <String>["Laptop Gaming", "Laptop văn phòng"]
                              .map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(location),
                                );
                              })
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              cubit.updateFormCategory(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (addProductKey.currentState!.validate()) {
                        cubit.submitCreateForm();
                      }
                    },
                    child: const Text("Thêm sản phẩm"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

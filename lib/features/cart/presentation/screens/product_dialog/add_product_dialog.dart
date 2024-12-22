import 'package:assesment_teklogue/core/formatter/currency_formatter.dart';
import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/core/themes/app_text_field.dart';
import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_products.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductDialog extends StatefulWidget {
  final Function(ProductModel) onProductAdded;
  const AddProductDialog({super.key, required this.onProductAdded});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late final ProductCubit _productCubit;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _productCubit = ProductCubit(
      getProductsUsecase: context.read<GetProducts>(),
    )..getProducts();
    _searchController.addListener(_listnener);
  }

  @override
  void dispose() {
    _productCubit.close();
    _searchController.removeListener(_listnener);
    _searchController.dispose();
    super.dispose();
  }

  void _listnener() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        backgroundColor: appColors.white,
        surfaceTintColor: appColors.white,
        title: Text(
          'Tambah Produk',
          style: appFonts.titleSmall.primary.ts,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildSearchField(),
          const SizedBox(height: 10),
          _buildProductList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppTextField(
        label: 'Cari Produk',
        controller: _searchController,
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductCubit, StateController<List<ProductModel>>>(
      bloc: _productCubit,
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is Error) {
          return Center(
            child: Text(
              state.inferredErrorMessage ?? '',
              style: appFonts.error.ts,
            ),
          );
        }

        if (state is Success) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...state.inferredData!.where(
                    (product) {
                      return product.productName
                          .toLowerCase()
                          .contains(_searchQuery);
                    },
                  ).map(
                    (product) {
                      return ListTile(
                        title: Text(
                          product.productName,
                          style: appFonts.primary.ts,
                        ),
                        subtitle: Text(
                          AppCurrencyFormatter.format(
                              product.baseUnitCostPrice ?? 0),
                          style: appFonts.gray.ts,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            widget.onProductAdded(product);
                            Navigator.pop(context, product);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

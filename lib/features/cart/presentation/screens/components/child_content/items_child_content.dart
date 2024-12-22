import 'package:assesment_teklogue/core/formatter/currency_formatter.dart';
import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsChildContent extends StatefulWidget {
  const ItemsChildContent({super.key});

  @override
  State<ItemsChildContent> createState() => _ItemsChildContentState();
}

class _ItemsChildContentState extends State<ItemsChildContent> {
  late final CartCubit _cartCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cartCubit = context.read<CartCubit>()..init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Text('Item', style: appFonts.primary.ts),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'Qty',
                style: appFonts.primary.ts,
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                'Price',
                style: appFonts.primary.ts,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        Divider(
          color: appColors.grayFont.withValues(
            red: 0.8,
            green: 0.8,
            blue: 0.8,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: BlocBuilder<CartCubit, StateController<CartState>>(
            bloc: _cartCubit,
            builder: (context, state) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Success) {
                return RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  trackColor: appColors.primary.withValues(
                    red: 0.8,
                    green: 0.8,
                    blue: 0.8,
                  ),
                  thumbColor: appColors.primary,
                  trackRadius: Radius.circular(50),
                  radius: Radius.circular(50),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: state.inferredData?.cartItems.length ?? 0,
                    itemBuilder: (context, index) {
                      final product =
                          state.inferredData?.cartItems[index].product;
                      final cartItem = state.inferredData?.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product?.productName ?? '',
                                    style: appFonts.bold.primary.ts,
                                  ),
                                  Text(
                                    AppCurrencyFormatter.format(
                                      product?.baseUnitCostPrice ?? 0,
                                    ),
                                    style: appFonts.caption.gray.ts,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _quantityButton(
                                    icon: Icons.remove,
                                    onTap: () {
                                      _cartCubit.reduceQuantity(product!);
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 20,
                                    child: Text(
                                      cartItem?.quantity.toString() ?? '',
                                      style: appFonts.ts,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  _quantityButton(
                                    icon: Icons.add,
                                    onTap: () {
                                      _cartCubit.addCartItem(product!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  AppCurrencyFormatter.format(
                                      cartItem?.total ?? 0),
                                  style: appFonts.primary.ts,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is Error) {
                return Center(child: Text(state.inferredErrorMessage ?? ''));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _quantityButton({required IconData icon, required Function() onTap}) {
    return Material(
      shape: CircleBorder(),
      color: appColors.primary,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            size: 10,
            color: appColors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:assesment_teklogue/core/themes/app_button.dart';
import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/core/themes/app_outline_button.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/dialogs/discount_dialog.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/child_content/items_child_content.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/dialogs/tax_dialog.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/child_content/total_summary_child_content.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/product_dialog/add_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSection extends StatelessWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konfirmasi',
                    style: appFonts.titleSmall.primary.ts,
                  ),
                  Text(
                    'Order #1',
                    style: appFonts.gray.ts,
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                icon: Icons.add,
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: appColors.white,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: AddProductDialog(
                          onProductAdded: (product) {
                            context.read<CartCubit>().addCartItem(product);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: appColors.grayFont.withValues(
              red: 0.8,
              green: 0.8,
              blue: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          ItemsChildContent(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  AppOutlineButton(
                    icon: Icons.sell_rounded,
                    adjustIconSize: 5,
                    color: appColors.primary,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: appColors.white,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: DiscountDialog(
                              onDiscountAdded: (discount) {
                                context
                                    .read<CartCubit>()
                                    .selectDiscount(discount);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Diskon',
                    style: appFonts.primary.ts,
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                children: [
                  AppOutlineButton(
                    icon: Icons.percent,
                    adjustIconSize: 5,
                    color: appColors.primary,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: appColors.white,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: TaxDialog(
                              onTaxAdded: (tax) {
                                context.read<CartCubit>().selectTax(tax);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Pajak',
                    style: appFonts.primary.ts,
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                children: [
                  AppOutlineButton(
                    icon: Icons.store,
                    adjustIconSize: 5,
                    color: appColors.primary,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Layanan',
                    style: appFonts.primary.ts,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: appColors.grayFont.withValues(
              red: 0.8,
              green: 0.8,
              blue: 0.8,
            ),
          ),
          TotalSummaryChildContent(),
        ],
      ),
    );
  }
}

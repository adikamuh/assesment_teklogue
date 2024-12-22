import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/sections/cart_section.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/sections/payment_section.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      body: Row(
        children: [
          Expanded(
            child: CartSection(),
          ),
          Expanded(
            child: PaymentSection(),
          ),
        ],
      ),
    );
  }
}

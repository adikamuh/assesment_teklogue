import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/features/cart/data/models/discount_model.dart';
import 'package:flutter/material.dart';

class DiscountDialog extends StatelessWidget {
  final Function(DiscountModel) onDiscountAdded;
  const DiscountDialog({
    super.key,
    required this.onDiscountAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        backgroundColor: appColors.white,
        surfaceTintColor: appColors.white,
        title: Text(
          'Tambah Diskon',
          style: appFonts.titleSmall.primary.ts,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildDiscountList(context),
        ],
      ),
    );
  }

  Widget _buildDiscountList(BuildContext context) {
    return ListTile(
      title: Text(
        'Diskon 10rb',
        style: appFonts.titleSmall.primary.ts,
      ),
      onTap: () {
        onDiscountAdded(
          DiscountModel(
            id: '1',
            title: 'Diskon 10rb',
            amount: 10000,
          ),
        );
        Navigator.pop(context);
      },
    );
  }
}

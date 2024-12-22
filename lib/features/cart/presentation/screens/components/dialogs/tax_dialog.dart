import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/features/cart/data/models/tax_model.dart';
import 'package:flutter/material.dart';

class TaxDialog extends StatelessWidget {
  final Function(TaxModel) onTaxAdded;
  const TaxDialog({
    super.key,
    required this.onTaxAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        backgroundColor: appColors.white,
        surfaceTintColor: appColors.white,
        title: Text(
          'Tambah Pajak',
          style: appFonts.titleSmall.primary.ts,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildTaxList(context),
        ],
      ),
    );
  }

  Widget _buildTaxList(BuildContext context) {
    return ListTile(
      title: Text(
        'Pajak 11%',
        style: appFonts.titleSmall.primary.ts,
      ),
      onTap: () {
        onTaxAdded(
          TaxModel(
            id: '1',
            title: 'Pajak 11%',
            percent: 11,
          ),
        );
        Navigator.pop(context);
      },
    );
  }
}

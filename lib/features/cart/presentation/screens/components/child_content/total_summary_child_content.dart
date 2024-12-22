import 'package:assesment_teklogue/core/formatter/currency_formatter.dart';
import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalSummaryChildContent extends StatelessWidget {
  const TotalSummaryChildContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, StateController<CartState>>(
      builder: (context, state) {
        final subtotal = state.inferredData?.subtotal ?? 0;
        final discountAmount = state.inferredData?.discount ?? 0;
        final taxAmount = state.inferredData?.tax ?? 0;
        return Column(
          children: [
            _buildSummaryItem(
              'Subtotal',
              AppCurrencyFormatter.format(subtotal),
            ),
            _buildSummaryItem(
              'Diskon',
              AppCurrencyFormatter.format(discountAmount),
            ),
            _buildSummaryItem(
              'Pajak',
              AppCurrencyFormatter.format(taxAmount),
            ),
            const SizedBox(height: 10),
            _buildTotal(
              AppCurrencyFormatter.format(
                state.inferredData?.total ?? 0,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: appFonts.gray.ts,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: appFonts.primary.ts,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildTotal(String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Total',
            style: appFonts.subtitle.bold.ts,
          ),
        ),
        Expanded(
          child: Text(
            total,
            style: appFonts.subtitle.primary.ts,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

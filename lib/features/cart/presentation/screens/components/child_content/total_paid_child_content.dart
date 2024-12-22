import 'package:assesment_teklogue/core/themes/app_button.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/core/themes/app_text_field.dart';
import 'package:assesment_teklogue/features/cart/data/models/denominal_enum.dart';
import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPaidChildContent extends StatefulWidget {
  final PaymentModel? selectedPaymentMethod;
  final MoneyMaskedTextController controller;
  const TotalPaidChildContent({
    super.key,
    required this.selectedPaymentMethod,
    required this.controller,
  });

  @override
  State<TotalPaidChildContent> createState() => _TotalPaidChildContentState();
}

class _TotalPaidChildContentState extends State<TotalPaidChildContent> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Bayar',
          style: appFonts.gray.ts,
        ),
        const SizedBox(height: 10),
        AppTextField(
          hint: 'Total harga',
          controller: widget.controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          enable: widget.selectedPaymentMethod?.id == '1',
        ),
        const SizedBox(height: 20),
        if (widget.selectedPaymentMethod?.id == '1') _buildDenominalButtons(),
      ],
    );
  }

  Widget _buildDenominalButtons() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...DenominalEnum.values.map(
          (e) => SizedBox(
            width: 150,
            child: AppButton(
              text: e.label,
              onTap: () {
                if (e == DenominalEnum.uangPas) {
                  final cartCubit = context.read<CartCubit>();
                  widget.controller.updateValue(
                    (cartCubit.state.inferredData?.total ?? 0).toDouble(),
                  );
                } else {
                  widget.controller.updateValue(e.value.toDouble());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

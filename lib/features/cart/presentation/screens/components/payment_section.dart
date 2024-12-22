import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/core/themes/app_button.dart';
import 'package:assesment_teklogue/core/themes/app_colors.dart';
import 'package:assesment_teklogue/core/themes/app_fonts.dart';
import 'package:assesment_teklogue/core/themes/app_outline_button.dart';
import 'package:assesment_teklogue/core/widget/app_selectable_chip.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/payment_cubit.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/components/total_paid_child_content.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  late final PaymentCubit _paymentCubit;
  final _controller = MoneyMaskedTextController(
    leftSymbol: 'Rp ',
    thousandSeparator: '.',
    decimalSeparator: '',
    precision: 0,
  );

  @override
  void initState() {
    super.initState();
    _paymentCubit = context.read<PaymentCubit>()..getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<PaymentCubit, StateController<PaymentState>>(
        listener: (context, paymentState) {
          if (paymentState is Success &&
              paymentState.inferredData?.selectedPaymentMethod != null) {
            final selectedPaymentMethod =
                paymentState.inferredData?.selectedPaymentMethod;
            if (selectedPaymentMethod!.id != '1') {
              final totalPaid =
                  context.read<CartCubit>().state.inferredData?.total ?? 0;
              _controller.updateValue(totalPaid.toDouble());
            }
          }
        },
        builder: (context, paymentState) {
          return BlocListener<CartCubit, StateController<CartState>>(
            listener: (context, cartState) {
              final selectedPaymentMethod =
                  paymentState.inferredData?.selectedPaymentMethod;
              if (cartState is Success &&
                  selectedPaymentMethod != null &&
                  selectedPaymentMethod.id != '1') {
                final totalPaid = cartState.inferredData?.total ?? 0;
                _controller.updateValue(totalPaid.toDouble());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Metode Pembayaran',
                  style: appFonts.titleSmall.primary.ts,
                ),
                if (paymentState.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (paymentState.isError)
                  Center(
                    child: Text(
                      paymentState.inferredErrorMessage ?? 'Terjadi kesalahan',
                      style: appFonts.error.ts,
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${paymentState.inferredData?.paymentMethods.length} opsi pembayaran tersedia',
                          style: appFonts.gray.ts,
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
                        Text(
                          'Metode Bayar',
                          style: appFonts.titleSmall.primary.ts,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ...paymentState.inferredData?.paymentMethods
                                    .map(
                                      (paymentMethod) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: AppSelectableChip(
                                          isSelected: paymentMethod.id ==
                                              paymentState.inferredData
                                                  ?.selectedPaymentMethod?.id,
                                          label: paymentMethod.title,
                                          onTap: () {
                                            _paymentCubit.selectPaymentMethod(
                                              paymentMethod,
                                            );
                                            _controller.clear();
                                          },
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                [],
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
                        Expanded(
                          child: TotalPaidChildContent(
                            selectedPaymentMethod: paymentState
                                .inferredData?.selectedPaymentMethod,
                            controller: _controller,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: AppOutlineButton(
                                text: 'Batalkan',
                                onTap: () async {
                                  await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Konfirmasi'),
                                        content: const Text(
                                          'Apakah Anda yakin ingin membatalkan transaksi?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<CartCubit>()
                                                  .clearAll();
                                              _paymentCubit.clearAll();
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('Ya'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: AppButton(
                                text: 'Bayar',
                                onTap: () async {
                                  final cartCubit = context.read<CartCubit>();
                                  final totalCart =
                                      cartCubit.state.inferredData?.total ?? 0;

                                  if (_controller.numberValue < totalCart) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Total bayar tidak valid'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (paymentState.inferredData
                                          ?.selectedPaymentMethod ==
                                      null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Pilih metode pembayaran terlebih dahulu',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  if (cartCubit.state.inferredData?.cartItems
                                          .isEmpty ??
                                      true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Keranjang belanja kosong',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Konfirmasi'),
                                        content: Text(
                                          'Apakah Anda yakin ingin membayar sebesar ${_controller.text}?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('Ya'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (result ?? false) {
                                    cartCubit.checkout(
                                      paymentMethod: paymentState
                                          .inferredData!.selectedPaymentMethod!,
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: appColors.success,
                                            content: const Text(
                                              'Transaksi berhasil',
                                            ),
                                          ),
                                        );
                                        cartCubit.clearAll();
                                        _paymentCubit.clearAll();
                                        _controller.clear();
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

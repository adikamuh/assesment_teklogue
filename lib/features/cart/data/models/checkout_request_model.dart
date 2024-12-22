import 'package:assesment_teklogue/features/cart/data/models/cart_item.dart';
import 'package:assesment_teklogue/features/cart/data/models/discount_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/tax_model.dart';

class CheckoutRequestModel {
  final List<CartItem> items;
  final DiscountModel? discount;
  final TaxModel? tax;
  final PaymentModel paymentMethod;
  final num subtotal;
  final num total;

  CheckoutRequestModel({
    required this.items,
    required this.discount,
    required this.tax,
    required this.paymentMethod,
    required this.subtotal,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'discount': discount?.toJson(),
      'tax': tax?.toJson(),
      'paymentMethod': paymentMethod.toJson(),
      'subtotal': subtotal,
      'total': total,
    };
  }
}

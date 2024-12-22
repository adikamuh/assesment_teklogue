import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  num get total => (product.baseUnitCostPrice ?? 0) * quantity;

  @override
  List<Object> get props => [product, quantity];

  CartItem copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}

import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/features/cart/data/models/cart_item.dart';
import 'package:assesment_teklogue/features/cart/data/models/checkout_request_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/discount_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:assesment_teklogue/features/cart/data/models/tax_model.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_products.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final DiscountModel? seletedDiscount;
  final TaxModel? seletedTax;

  const CartState({
    required this.cartItems,
    this.seletedDiscount,
    this.seletedTax,
  });

  num get subtotal {
    return cartItems.fold<num>(
      0,
      (previousValue, element) {
        return previousValue +
            ((element.product.baseUnitCostPrice ?? 0) * element.quantity);
      },
    );
  }

  num get discount {
    return seletedDiscount?.amount ?? 0;
  }

  num get total {
    return subtotal - discount + tax;
  }

  num get subtotalAfterDiscount {
    return subtotal - discount;
  }

  num get tax {
    return seletedTax?.percent != null
        ? subtotalAfterDiscount * (seletedTax!.percent / 100)
        : 0;
  }

  @override
  List<Object?> get props => [
        cartItems,
        seletedDiscount,
        seletedTax,
      ];

  CartState copyWith({
    List<CartItem>? cartItems,
    DiscountModel? seletedDiscount,
    TaxModel? seletedTax,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      seletedDiscount: seletedDiscount ?? this.seletedDiscount,
      seletedTax: seletedTax ?? this.seletedTax,
    );
  }
}

class CartCubit extends Cubit<StateController<CartState>> {
  final GetProducts getProducts;
  CartCubit({
    required this.getProducts,
  }) : super(StateController.idle());

  void init() async {
    emit(StateController.loading());
    try {
      final products = await getProducts();
      final selectedProducts = products
          .where((p) =>
              p.productCategoryId == 2 &&
              p.productType?.toLowerCase() == 'inventory')
          .take(5)
          .toList();

      emit(
        StateController.success(
          CartState(
            cartItems: selectedProducts
                .map(
                  (product) => CartItem(
                    product: product,
                    quantity: 1,
                  ),
                )
                .toList(),
          ),
        ),
      );
    } catch (e) {
      emit(StateController.error(errorMessage: e.toString()));
    }
  }

  void addCartItem(ProductModel product) {
    final cartItems = state.inferredData?.cartItems;
    final isProductExist =
        cartItems?.any((item) => item.product.id == product.id);

    if (isProductExist ?? false) {
      final updatedCartItems = cartItems?.map((item) {
        if (item.product.id == product.id) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
      emit(
        StateController.success(
          CartState(
            cartItems: updatedCartItems ?? [],
          ),
        ),
      );
    } else {
      addQuantity(product);
    }
  }

  void removeCartItem(ProductModel product) {
    final cartItems = state.inferredData?.cartItems;
    final updatedCartItems = cartItems?.where((item) {
      return item.product.id != product.id;
    }).toList();
    emit(
      StateController.success(
        CartState(
          cartItems: updatedCartItems ?? [],
        ),
      ),
    );
  }

  void addQuantity(ProductModel product) {
    final cartItems = state.inferredData?.cartItems;

    final isProductExist =
        cartItems?.any((item) => item.product.id == product.id);

    late final List<CartItem> updatedCartItems;
    if (isProductExist ?? false) {
      updatedCartItems = cartItems?.map((item) {
            if (item.product.id == product.id) {
              return item.copyWith(quantity: item.quantity + 1);
            }
            return item;
          }).toList() ??
          [];
    } else {
      updatedCartItems = [
        ...cartItems ?? [],
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
    }

    emit(
      StateController.success(
        CartState(
          cartItems: updatedCartItems,
        ),
      ),
    );
  }

  void reduceQuantity(ProductModel product) {
    final cartItems = state.inferredData?.cartItems;

    final isQuantityMoreThanOne = cartItems?.any((item) {
      return item.product.id == product.id && item.quantity > 1;
    });

    late final List<CartItem> updatedCartItems;
    if (isQuantityMoreThanOne ?? false) {
      updatedCartItems = cartItems?.map((item) {
            if (item.product.id == product.id) {
              return item.copyWith(quantity: item.quantity - 1);
            }
            return item;
          }).toList() ??
          [];
    } else {
      updatedCartItems = cartItems?.where((item) {
            return item.product.id != product.id;
          }).toList() ??
          [];
    }

    emit(
      StateController.success(
        CartState(
          cartItems: updatedCartItems,
        ),
      ),
    );
  }

  void selectDiscount(DiscountModel discount) {
    final data = state.inferredData;

    if (data == null) return;

    emit(
      StateController.success(
        state.inferredData!.copyWith(seletedDiscount: discount),
      ),
    );
  }

  void removeDiscount() {
    final data = state.inferredData;

    if (data == null) return;

    emit(
      StateController.success(
        state.inferredData!.copyWith(seletedDiscount: null),
      ),
    );
  }

  void selectTax(TaxModel tax) {
    final data = state.inferredData;

    if (data == null) return;

    emit(
      StateController.success(
        state.inferredData!.copyWith(seletedTax: tax),
      ),
    );
  }

  void removeTax() {
    final data = state.inferredData;

    if (data == null) return;

    emit(
      StateController.success(
        state.inferredData!.copyWith(seletedTax: null),
      ),
    );
  }

  void clearAll() {
    emit(
      StateController.success(
        CartState(
          cartItems: [],
        ),
      ),
    );
  }

  void checkout({
    required PaymentModel paymentMethod,
    required Function() onSuccess,
  }) {
    try {
      final requestParam = CheckoutRequestModel(
        items: state.inferredData?.cartItems ?? [],
        discount: state.inferredData?.seletedDiscount,
        tax: state.inferredData?.seletedTax,
        paymentMethod: paymentMethod,
        subtotal: state.inferredData?.subtotal ?? 0,
        total: state.inferredData?.total ?? 0,
      );

      Logger().i(requestParam.toJson());

      clearAll();
      onSuccess();
    } catch (e) {
      emit(StateController.error(errorMessage: e.toString()));
    }
  }
}

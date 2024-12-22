import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_payment_methods.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentState extends Equatable {
  final List<PaymentModel> paymentMethods;
  final PaymentModel? selectedPaymentMethod;

  const PaymentState({
    required this.paymentMethods,
    this.selectedPaymentMethod,
  });

  PaymentState copyWith({
    List<PaymentModel>? paymentMethods,
    PaymentModel? selectedPaymentMethod,
  }) {
    return PaymentState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [paymentMethods, selectedPaymentMethod];
}

class PaymentCubit extends Cubit<StateController<PaymentState>> {
  final GetPaymentMethods getPaymentMethodsUsecase;

  PaymentCubit({
    required this.getPaymentMethodsUsecase,
  }) : super(StateController.idle());

  void getPaymentMethods() async {
    emit(StateController.loading());
    try {
      final paymentMethods = await getPaymentMethodsUsecase.call();
      emit(
        StateController.success(
          PaymentState(
            paymentMethods: paymentMethods,
          ),
        ),
      );
    } catch (e) {
      emit(StateController.error(errorMessage: e.toString()));
    }
  }

  void selectPaymentMethod(PaymentModel paymentMethod) {
    final currentState = state.inferredData;
    if (currentState == null) return;

    emit(
      StateController.success(
        currentState.copyWith(selectedPaymentMethod: paymentMethod),
      ),
    );
  }

  void clearSelectedPaymentMethod() {
    final currentState = state.inferredData;
    if (currentState == null) return;

    emit(
      StateController.success(
        currentState.copyWith(selectedPaymentMethod: null),
      ),
    );
  }

  void clearAll() {
    emit(StateController.idle());
    getPaymentMethods();
  }
}

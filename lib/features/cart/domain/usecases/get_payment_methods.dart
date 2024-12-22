import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';
import 'package:assesment_teklogue/features/cart/domain/repositories/payment_repository.dart';

class GetPaymentMethods {
  final PaymentRepository _paymentRepository;

  GetPaymentMethods(this._paymentRepository);

  Future<List<PaymentModel>> call() async {
    return await _paymentRepository.getPaymentMethods();
  }
}

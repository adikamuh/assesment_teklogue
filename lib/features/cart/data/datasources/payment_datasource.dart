import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';

class PaymentDatasource {
  Future<List<PaymentModel>> getPaymentMethods() async {
    return [
      PaymentModel(id: '1', title: 'Cash'),
      PaymentModel(id: '2', title: 'EDC BCA'),
      PaymentModel(id: '3', title: 'QRIS'),
    ];
  }
}

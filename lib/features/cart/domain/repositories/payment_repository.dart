import 'package:assesment_teklogue/features/cart/data/datasources/payment_datasource.dart';
import 'package:assesment_teklogue/features/cart/data/models/payment_model.dart';

class PaymentRepository {
  final PaymentDatasource datasource;

  PaymentRepository(this.datasource);

  Future<List<PaymentModel>> getPaymentMethods() async {
    return datasource.getPaymentMethods();
  }
}

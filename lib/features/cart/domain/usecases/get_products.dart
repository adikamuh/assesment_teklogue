import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:assesment_teklogue/features/cart/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductModel>> call() async {
    return await repository.getProducts();
  }
}

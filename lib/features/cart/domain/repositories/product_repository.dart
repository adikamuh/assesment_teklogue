import 'package:assesment_teklogue/features/cart/data/datasources/product_datasources.dart';
import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';

class ProductRepository {
  final ProductDatasources productDatasources;

  ProductRepository(this.productDatasources);

  Future<List<ProductModel>> getProducts() async {
    return (await productDatasources.getProducts()).toList();
  }
}

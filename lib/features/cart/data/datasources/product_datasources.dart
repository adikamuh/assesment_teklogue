import 'dart:convert';

import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:flutter/services.dart';

class ProductDatasources {
  Future<List<ProductModel>> getProducts() async {
    final Map<String, dynamic> data = await _readJson();
    final List<ProductModel> products = [];
    for (final Map<String, dynamic> product in data['data']) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }

  Future<Map<String, dynamic>> _readJson() async {
    final String data = await rootBundle.loadString(
      'assets/json/products.json',
    );
    return json.decode(data);
  }
}

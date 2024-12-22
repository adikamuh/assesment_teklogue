import 'package:assesment_teklogue/core/models/state_controller.dart';
import 'package:assesment_teklogue/features/cart/data/models/product_model.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ProductCubit extends Cubit<StateController<List<ProductModel>>> {
  final GetProducts getProductsUsecase;
  ProductCubit({required this.getProductsUsecase})
      : super(StateController.idle());

  void getProducts() async {
    emit(StateController.loading());
    try {
      final List<ProductModel> products = await getProductsUsecase.call();
      emit(StateController.success(products));
    } catch (e, s) {
      Logger().e(e.toString(), error: e, stackTrace: s);
      emit(StateController.error(errorMessage: e.toString()));
    }
  }
}

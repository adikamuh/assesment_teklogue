import 'package:assesment_teklogue/features/cart/data/datasources/payment_datasource.dart';
import 'package:assesment_teklogue/features/cart/data/datasources/product_datasources.dart';
import 'package:assesment_teklogue/features/cart/domain/repositories/payment_repository.dart';
import 'package:assesment_teklogue/features/cart/domain/repositories/product_repository.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_payment_methods.dart';
import 'package:assesment_teklogue/features/cart/domain/usecases/get_products.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:assesment_teklogue/features/cart/presentation/blocs/payment_cubit.dart';
import 'package:assesment_teklogue/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _datasources(),
      child: MultiRepositoryProvider(
        providers: _repositories(),
        child: MultiRepositoryProvider(
          providers: _usecases(),
          child: MultiBlocProvider(
            providers: _blocs(),
            child: const MaterialApp(
              home: CartScreen(),
            ),
          ),
        ),
      ),
    );
  }

  List<RepositoryProvider> _datasources() {
    return [
      RepositoryProvider<ProductDatasources>(
        create: (context) => ProductDatasources(),
      ),
      RepositoryProvider<PaymentDatasource>(
        create: (context) => PaymentDatasource(),
      ),
    ];
  }

  List<RepositoryProvider> _repositories() {
    return [
      RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepository(
          context.read(),
        ),
      ),
      RepositoryProvider<PaymentRepository>(
        create: (context) => PaymentRepository(
          context.read(),
        ),
      ),
    ];
  }

  List<RepositoryProvider> _usecases() {
    return [
      RepositoryProvider<GetProducts>(
        create: (context) => GetProducts(
          context.read<ProductRepository>(),
        ),
      ),
      RepositoryProvider<GetPaymentMethods>(
        create: (context) => GetPaymentMethods(
          context.read<PaymentRepository>(),
        ),
      ),
    ];
  }

  List<BlocProvider> _blocs() {
    return [
      BlocProvider<CartCubit>(
        create: (context) => CartCubit(
          getProducts: context.read<GetProducts>(),
        ),
      ),
      BlocProvider<PaymentCubit>(
        create: (context) => PaymentCubit(
          getPaymentMethodsUsecase: context.read<GetPaymentMethods>(),
        ),
      ),
    ];
  }
}

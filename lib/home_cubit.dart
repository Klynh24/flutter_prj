import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> products2;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> products3;

  HomeLoaded({
    required this.products,
    required this.products2,
    required this.categories,
    required this.products3,
  });
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchData() async {
    emit(HomeLoading());

    await Future.delayed(const Duration(seconds: 5));

    final products = [
      {
        'name': 'Organic Bananas',
        'desc': '7pcs, Priceg',
        'price': '\$4.99',
        'image': 'assets/banana_img.png',
      },
      {
        'name': 'Red Apple',
        'desc': '1kg, Priceg',
        'price': '\$3.59',
        'image': 'assets/product_img.png',
      },
      {
        'name': 'Green Grapes',
        'desc': '500g, Priceg',
        'price': '\$5.99',
        'image': 'assets/product_img.png',
      },
    ];
    final products2 = [
      {
        'name': 'Bell Pepper Red',
        'desc': '1kg, Priceg',
        'price': '\$4.99',
        'image': 'assets/bellpepper_img.png',
      },
      {
        'name': 'Ginger',
        'desc': '250mg, Priceg',
        'price': '\$3.59',
        'image': 'assets/ginger_img.png',
      },
      {
        'name': 'Green Grapes',
        'desc': '500g, Priceg',
        'price': '\$5.99',
        'image': 'assets/product_img.png',
      },
    ];
    final categories = [
      {
        'name': 'Pulses',
        'image': 'assets/pulses_img.png',
        'color': const Color(0xFFFFF4E3),
      },
      {
        'name': 'Rice',
        'image': 'assets/rice_img.png',
        'color': const Color(0xFFE9F7EE),
      },
      {
        'name': 'Oil',
        'image': 'assets/product_img.png',
        'color': const Color(0xFFE7F2FF),
      },
    ];
    final products3 = [
      {
        'name': 'Beef Bone',
        'desc': '1kg, Priceg',
        'price': '\$4.99',
        'image': 'assets/beefbone_img.png',
      },
      {
        'name': 'Broiler Chicken',
        'desc': '1kg, Priceg',
        'price': '\$3.59',
        'image': 'assets/broilerchicken_img.png',
      },
      {
        'name': 'Green Grapes',
        'desc': '500g, Priceg',
        'price': '\$5.99',
        'image': 'assets/product_img.png',
      },
    ];

    // 4. Phát ra trạng thái đã có dữ liệu
    emit(
      HomeLoaded(
        products: products,
        products2: products2,
        categories: categories,
        products3: products3,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreState {
  final List<Map<String, dynamic>> categories;
  final bool isLoading;

  ExploreState({required this.categories, this.isLoading = false});

  ExploreState copyWith({
    List<Map<String, dynamic>>? categories,
    bool? isLoading,
  }) {
    return ExploreState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreState(categories: _initialData()));

  Future<void> onItemClicked() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(isLoading: false));
  }

  static List<Map<String, dynamic>> _initialData() {
    return [
      {
        'name': 'Frash Fruits\n& Vegetable',
        'image': 'assets/fruitsvegetables_img.png',
        'color': const Color(0xFF53B175).withOpacity(0.1),
        'borderColor': const Color(0xFF53B175),
      },
      {
        'name': 'Cooking Oil\n& Ghee',
        'image': 'assets/cookingoil_img.png',
        'color': const Color(0xFFF8A44C).withOpacity(0.1),
        'borderColor': const Color(0xFFF8A44C),
      },
      {
        'name': 'Meat & Fish',
        'image': 'assets/meatfish_img.png',
        'color': const Color(0xFFF7A593).withOpacity(0.25),
        'borderColor': const Color(0xFFF7A593),
      },
      {
        'name': 'Bakery & Snacks',
        'image': 'assets/bakerysnacks_img.png',
        'color': const Color(0xFFD3B0E0).withOpacity(0.25),
        'borderColor': const Color(0xFFD3B0E0),
      },
      {
        'name': 'Dairy & Eggs',
        'image': 'assets/dairyeggs_img.png',
        'color': const Color(0xFFFDE598).withOpacity(0.25),
        'borderColor': const Color(0xFFFDE598),
      },
      {
        'name': 'Beverages',
        'image': 'assets/beverages_img.png',
        'color': const Color(0xFFB7DFF5).withOpacity(0.25),
        'borderColor': const Color(0xFFB7DFF5),
      },
    ];
  }
}

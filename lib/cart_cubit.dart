import 'package:flutter_bloc/flutter_bloc.dart';

class CartState {
  final List<Map<String, dynamic>> categories;

  final Map<String, dynamic>? selectedCategory;

  final bool isDropdownOpen;
  final bool isSubDropdownOpen;

  final List<Map<String, dynamic>> cartItems;

  CartState({
    required this.categories,
    this.selectedCategory,
    this.isDropdownOpen = false,
    this.isSubDropdownOpen = true,
    this.cartItems = const [],
  });

  CartState copyWith({
    List<Map<String, dynamic>>? categories,
    Map<String, dynamic>? selectedCategory,
    bool? isDropdownOpen,
    bool? isSubDropdownOpen,
    List<Map<String, dynamic>>? cartItems,
  }) {
    return CartState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isDropdownOpen: isDropdownOpen ?? this.isDropdownOpen,
      isSubDropdownOpen: isSubDropdownOpen ?? this.isSubDropdownOpen,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(categories: _initialData()));

  void toggleDropdown() {
    emit(state.copyWith(isDropdownOpen: !state.isDropdownOpen));
  }

  void toggleSubDropdown() {
    emit(state.copyWith(isSubDropdownOpen: !state.isSubDropdownOpen));
  }

  void selectCategory(Map<String, dynamic> category) {
    emit(
      state.copyWith(
        selectedCategory: category,
        isDropdownOpen: false,
        isSubDropdownOpen: true,
      ),
    );
  }

  void addToCart(Map<String, dynamic> product, String categoryName) {
    final List<Map<String, dynamic>> updatedCart = List.from(state.cartItems);

    final index = updatedCart.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (index != -1) {
      updatedCart[index] = Map.from(updatedCart[index]);
      updatedCart[index]['qty'] = (updatedCart[index]['qty'] ?? 1) + 1;
    } else {
      final newItem = Map<String, dynamic>.from(product);
      newItem['qty'] = 1;

      newItem['categoryName'] = categoryName;

      updatedCart.add(newItem);
    }

    emit(state.copyWith(cartItems: updatedCart));
  }

  void incrementItem(String productName) {
    final List<Map<String, dynamic>> updatedCart = List.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item['name'] == productName);

    if (index != -1) {
      updatedCart[index] = Map.from(updatedCart[index]);
      updatedCart[index]['qty'] = (updatedCart[index]['qty'] ?? 1) + 1;
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  void decrementItem(String productName) {
    final List<Map<String, dynamic>> updatedCart = List.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item['name'] == productName);

    if (index != -1) {
      int currentQty = updatedCart[index]['qty'] ?? 1;

      if (currentQty > 1) {
        updatedCart[index] = Map.from(updatedCart[index]);
        updatedCart[index]['qty'] = currentQty - 1;
      } else {
        updatedCart.removeAt(index);
      }

      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  static List<Map<String, dynamic>> _initialData() {
    return [
      {
        'name': 'Fruit & Vegetable',
        'image': 'assets/fruitsvegetables_img.png',
        'description':
            'High In Vitamins (Especially Vitamin C And Folate), Dietary Fiber And Various Antioxidants.',
        'items': [
          {
            'name': 'Organic Bananas',
            'image': 'assets/banana_img.png',
            'price': '\$4.99',
            'desc': '7pcs, Priceg',
          },
          {
            'name': 'Red Apple',
            'image': 'assets/product_img.png',
            'price': '\$3.59',
            'desc': '1kg, Priceg',
          },
          {
            'name': 'Bell Pepper Red',
            'image': 'assets/bellpepper_img.png',
            'price': '\$4.99',
            'desc': '1kg, Priceg',
          },
          {
            'name': 'Ginger',
            'image': 'assets/ginger_img.png',
            'price': '\$2.99',
            'desc': '250mg, Priceg',
          },
          {
            'name': 'Green Grapes',
            'image': 'assets/product_img.png',
            'price': '\$5.99',
            'desc': '500g, Priceg',
          },
        ],
      },
      {
        'name': 'Meat & Fish',
        'image': 'assets/meatfish_img.png',
        'description':
            'Rich source of high-quality protein, iron, zinc, and B vitamins.',
        'items': [
          {
            'name': 'Beef Bone',
            'image': 'assets/beefbone_img.png',
            'price': '\$15.99',
            'desc': '1kg, Priceg',
          },
          {
            'name': 'Broiler Chicken',
            'image': 'assets/broilerchicken_img.png',
            'price': '\$8.50',
            'desc': '1kg, Priceg',
          },
        ],
      },
      {
        'name': 'Dairy & Egg',
        'image': 'assets/dairyeggs_img.png',
        'description':
            'Provide calcium, vitamin D, and protein needed for strong bones and teeth.',
        'items': [
          {
            'name': 'Egg Chicken Red',
            'image': 'assets/product_img.png',
            'price': '\$1.99',
            'desc': '4pcs, Priceg',
          },
        ],
      },
      {
        'name': 'Oil',
        'image': 'assets/cookingoil_img.png',
        'description': 'Essential fats for energy and cell structure.',
        'items': [],
      },
      {
        'name': 'Bakery',
        'image': 'assets/bakerysnacks_img.png',
        'description': 'Freshly baked goods rich in carbohydrates.',
        'items': [],
      },
      {
        'name': 'Beverage',
        'image': 'assets/beverages_img.png',
        'description': 'Refreshing drinks to keep you hydrated.',
        'items': [
          {
            'name': 'Diet Coke',
            'image': 'assets/beverages_img.png',
            'price': '\$1.50',
            'desc': '355ml, Priceg',
          },
        ],
      },
    ];
  }
}

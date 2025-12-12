import 'package:flutter_bloc/flutter_bloc.dart';

class DetailState {
  final String name;
  final String description;
  final String productDetail;
  final String nutritions;
  final double price;
  final String image;
  final int quantity;
  final bool isFavorite;
  final double rating;

  DetailState({
    required this.name,
    required this.description,
    required this.productDetail,
    required this.nutritions,
    required this.price,
    required this.image,
    this.quantity = 1,
    this.isFavorite = false,
    this.rating = 5.0,
  });

  String get priceString => "\$${price.toStringAsFixed(2)}";

  String get totalPriceString => "\$${(price * quantity).toStringAsFixed(2)}";

  DetailState copyWith({
    String? name,
    String? description,
    String? productDetail,
    String? nutritions,
    double? price,
    String? image,
    int? quantity,
    bool? isFavorite,
    double? rating,
  }) {
    return DetailState(
      name: name ?? this.name,
      description: description ?? this.description,
      productDetail: productDetail ?? this.productDetail,
      nutritions: nutritions ?? this.nutritions,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
    );
  }
}

class DetailCubit extends Cubit<DetailState> {
  DetailCubit(Map<String, dynamic> product)
    : super(_initialStateFromData(product));

  static DetailState _initialStateFromData(Map<String, dynamic> product) {
    double parsedPrice = 0.0;
    try {
      String priceStr = product['price']?.toString() ?? "0";
      priceStr = priceStr.replaceAll('\$', '');
      parsedPrice = double.parse(priceStr);
    } catch (e) {
      parsedPrice = 0.0;
    }

    return DetailState(
      name: product['name'] ?? "Unknown Product",

      description: product['desc'] ?? "No description",

      productDetail:
          product['detail'] ??
          "Apples are nutritious. Apples may be good for weight loss. "
              "Apples may be good for your heart. As part of a healthful and varied diet.",

      nutritions: product['nutritions'] ?? "100gr",

      image: product['image'] ?? "assets/product_img.png",

      price: parsedPrice,
      quantity: 1,
      isFavorite: false,
      rating: 5.0,
    );
  }

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }
}

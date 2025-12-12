import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_cubit.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(product),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F3F2),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Image.asset(state.image, fit: BoxFit.contain),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 20,
                      child: const Icon(Icons.ios_share, color: Colors.black),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              state.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: state.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                              size: 30,
                            ),
                            onPressed: () =>
                                context.read<DetailCubit>().toggleFavorite(),
                          ),
                        ],
                      ),
                      Text(
                        state.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _quantityButton(
                                Icons.remove,
                                () => context
                                    .read<DetailCubit>()
                                    .decreaseQuantity(),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${state.quantity}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _quantityButton(
                                Icons.add,
                                () => context
                                    .read<DetailCubit>()
                                    .increaseQuantity(),
                                isAdd: true,
                              ),
                            ],
                          ),
                          Text(
                            state.totalPriceString,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      const Divider(),

                      Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          title: const Text(
                            "Product Detail",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.black,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                state.productDetail,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      _buildRowItem("Nutritions", state.nutritions),
                      const Divider(),

                      _buildRowItem("Review", "", isRating: true),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF53B175),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Add To Basket",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _quantityButton(
    IconData icon,
    VoidCallback onTap, {
    bool isAdd = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isAdd ? const Color(0xFF53B175) : Colors.grey,
        size: 35,
      ),
    );
  }

  Widget _buildRowItem(
    String title,
    String trailingText, {
    bool isRating = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              if (isRating) ...[
                ...List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    trailingText,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

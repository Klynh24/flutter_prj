import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _subScrollController = ScrollController();

  @override
  void dispose() {
    _mainScrollController.dispose();
    _subScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: state.isDropdownOpen ? 500 : 100,
                          margin: EdgeInsets.zero,
                          color: const Color(0xFF53B175),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    context.read<CartCubit>().toggleDropdown(),
                                behavior: HitTestBehavior.translucent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Food Type",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          state.selectedCategory != null
                                              ? state.selectedCategory!['name']
                                              : "Select food type",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      state.isDropdownOpen
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),

                              if (state.isDropdownOpen)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: ScrollbarTheme(
                                      data: ScrollbarThemeData(
                                        thumbColor: MaterialStateProperty.all(
                                          Colors.white.withOpacity(0.8),
                                        ),
                                        radius: const Radius.circular(10),
                                        thickness: MaterialStateProperty.all(4),
                                      ),
                                      child: Scrollbar(
                                        controller: _mainScrollController,
                                        thumbVisibility: true,
                                        child: ListView.builder(
                                          controller: _mainScrollController,
                                          itemCount: state.categories.length,
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            final item =
                                                state.categories[index];
                                            return _buildMainListItem(
                                              item: item,
                                              onTapSelect: () {
                                                context
                                                    .read<CartCubit>()
                                                    .selectCategory(item);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (state.selectedCategory != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Detail Information About ",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: state.selectedCategory!['name'],
                                        style: const TextStyle(
                                          color: Color(0xFF53B175),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.selectedCategory!['description'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: double.infinity,
                            height: state.isSubDropdownOpen ? 250 : 60,
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 170,
                              top: 10,
                              bottom: 10,
                            ),
                            color: const Color(0xFF53B175).withOpacity(0.9),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => context
                                      .read<CartCubit>()
                                      .toggleSubDropdown(),
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Select item",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        state.isSubDropdownOpen
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),

                                if (state.isSubDropdownOpen)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: ScrollbarTheme(
                                        data: ScrollbarThemeData(
                                          thumbColor: MaterialStateProperty.all(
                                            Colors.white.withOpacity(0.8),
                                          ),
                                          radius: const Radius.circular(10),
                                          thickness: MaterialStateProperty.all(
                                            3,
                                          ),
                                        ),
                                        child: Scrollbar(
                                          controller: _subScrollController,
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            controller: _subScrollController,
                                            itemCount:
                                                (state.selectedCategory!['items']
                                                        as List)
                                                    .length,
                                            padding: const EdgeInsets.only(
                                              right: 15,
                                            ),
                                            itemBuilder: (context, index) {
                                              final subItem = state
                                                  .selectedCategory!['items'][index];

                                              return GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CartCubit>()
                                                      .addToCart(
                                                        subItem,
                                                        state
                                                            .selectedCategory!['name'],
                                                      );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 25.0,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 45,
                                                        height: 45,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              right: 15,
                                                            ),
                                                        child: Image.asset(
                                                          subItem['image'],
                                                          fit: BoxFit.contain,
                                                          errorBuilder:
                                                              (
                                                                _,
                                                                __,
                                                                ___,
                                                              ) => const Icon(
                                                                Icons.circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          subItem['name'],
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          if (state.cartItems.isNotEmpty)
                            _buildGroupedCartList(state.cartItems, context),

                          const SizedBox(height: 50),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedCartList(
    List<Map<String, dynamic>> cartItems,
    BuildContext context,
  ) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in cartItems) {
      String catName = item['categoryName'] ?? 'Other';
      if (!groupedItems.containsKey(catName)) {
        groupedItems[catName] = [];
      }
      groupedItems[catName]!.add(item);
    }

    return Column(
      children: groupedItems.entries.map((entry) {
        String categoryTitle = entry.key;
        List<Map<String, dynamic>> items = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Color(0xFF53B175), thickness: 1),
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 30, color: Colors.grey),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                final cartItem = items[index];
                return _buildCartItemRow(cartItem, context);
              },
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCartItemRow(
    Map<String, dynamic> cartItem,
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(right: 15),
          child: Image.asset(
            cartItem['image'],
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                cartItem['price'] ?? "",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),

        Row(
          children: [
            InkWell(
              onTap: () =>
                  context.read<CartCubit>().decrementItem(cartItem['name']),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(Icons.remove, color: Colors.grey, size: 20),
              ),
            ),
            SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  "${cartItem['qty']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  context.read<CartCubit>().incrementItem(cartItem['name']),
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF53B175),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainListItem({
    required Map<String, dynamic> item,
    required VoidCallback onTapSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(right: 15),
            child: Image.asset(
              item['image'],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.fastfood, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              item['name'],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 35,
            width: 100,
            child: ElevatedButton(
              onPressed: onTapSelect,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                foregroundColor: const Color(0xFF53B175),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                "Select",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

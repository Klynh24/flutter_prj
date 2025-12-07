import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, dynamic>> categories = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Find Products",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black87),
                  hintText: 'Search Store',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];
                return Container(
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: item['borderColor'].withOpacity(0.7),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          item['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

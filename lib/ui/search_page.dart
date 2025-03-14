import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/fruites_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, String>> categories = [
    {'name': 'Fruits', 'image': 'assets/Fruites.png'},
    {'name': 'Milk', 'image': 'assets/Milk.png'},
    {'name': 'Meats', 'image': 'assets/Meats.png'},
    {'name': 'Nuts', 'image': 'assets/Nuts.png'},
    {'name': 'Vegetables', 'image': 'assets/Vegetable.png'},
    {'name': 'Fancy', 'image': 'assets/Fancy.png'},
    {'name': 'Rice', 'image': 'assets/Rice.png'},
    {'name': 'Egg', 'image': 'assets/Egg.png'},
    {'name': 'Pet Food', 'image': 'assets/Pet Food.png'},
    {'name': 'Perfume', 'image': 'assets/Perfume.png'},
    {'name': 'Sanitery Pad', 'image': 'assets/Sanitery pads.png'},
    {'name': 'Bakery', 'image': 'assets/Bakery.png'},
    {'name': 'Gadget', 'image': 'assets/Gadget.png'},
    {'name': 'Bevarage', 'image': 'assets/Bevarages.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Center(
              child: Text(
                'Find Products',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFFCF8E8), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(color: Color(0x91FCF8E8)),
                decoration: InputDecoration(
                  hintText: "Search somthing...",
                  hintStyle: TextStyle(color: Color(0x91FCF8E8), fontSize: 12),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0x91FCF8E8)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: categories.map((category) {
                  return _buildCategoryCard(
                      category['name']!, category['image']!);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FruitesPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDDD9CB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

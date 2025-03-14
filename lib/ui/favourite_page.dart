import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final List<Map<String, dynamic>> favourites = [
    {
      'name': 'Banana',
      'image': 'assets/Banana.png',
      'price': 80,
      'mrp': 100,
    },
    {
      'name': 'Carrot',
      'image': 'assets/Carrot.png',
      'price': 80,
      'mrp': 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Column(
        children: [
          const SizedBox(height: 63),
          Row(
            children: [
              const SizedBox(width: 40),
              const BackButton(color: Color(0xffFCF8E8)),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xffFCF8E8),
                ),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Favourites',
              style: TextStyle(
                color: Color(0xFFFCF8E8),
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.24,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final item = favourites[index];
                return FavouriteItemCard(item: item);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF5E9B5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Center(
                child:
                    Text('Add to Cart', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavouriteItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const FavouriteItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0808),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xDBFCF8E8)),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xF4CCC9BC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(item['image'], fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      color: Color(0xFFFCF8E8),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'MRP ₹${item['mrp']}',
                    style: const TextStyle(
                      color: Color(0xCEB4B2A9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${((1 - item['price'] / item['mrp']) * 100).toStringAsFixed(0)}% OFF',
                    style: const TextStyle(
                      color: Color(0xCE7FFC83),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '₹${item['price']}',
                    style: const TextStyle(
                      color: Color(0xFFFCF8E8),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

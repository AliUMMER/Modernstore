import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/product_details.dart';

class FruitesPage extends StatefulWidget {
  const FruitesPage({super.key});

  @override
  State<FruitesPage> createState() => _FruitesPageState();
}

class _FruitesPageState extends State<FruitesPage> {
  final List<Map<String, dynamic>> fruits = [
    {'name': 'Banana', 'price': 80, 'mrp': 100, 'image': 'assets/Banana.png'},
    {'name': 'Orange', 'price': 80, 'mrp': 100, 'image': 'assets/Orange.png'},
    {
      'name': 'Strawberry',
      'price': 80,
      'mrp': 100,
      'image': 'assets/image 43.png'
    },
    {'name': 'Lemon', 'price': 80, 'mrp': 100, 'image': 'assets/lemon.png'},
    {
      'name': 'Watermelon',
      'price': 80,
      'mrp': 100,
      'image': 'assets/Watermelon.png'
    },
    {'name': 'Apple', 'price': 80, 'mrp': 100, 'image': 'assets/Apple.png'},
    {'name': 'Mango', 'price': 80, 'mrp': 100, 'image': 'assets/Mango.png'},
    {'name': 'Grapes', 'price': 80, 'mrp': 100, 'image': 'assets/Grapes.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text('Fruits', style: TextStyle(color: Color(0xffF5E9B5)))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            final fruit = fruits[index];
            return FruitCard(fruit: fruit);
          },
        ),
      ),
    );
  }
}

class FruitCard extends StatelessWidget {
  final Map<String, dynamic> fruit;

  const FruitCard({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetails()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // **Fruit Image Container**
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFFCCC9BC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  fruit['image'],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // **Fruit Name**
            Text(
              fruit['name'],
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),

            // **Price & MRP**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MRP: \u{20B9}${fruit['mrp']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '\u{20B9}${fruit['price']}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),

            // **Discount**
            const Text(
              '20% OFF',
              style: TextStyle(color: Colors.green),
            ),

            // **Add Button**
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/ui/products/product_details.dart';

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
          child: Text(
            'Fruits',
            style: GoogleFonts.inter(
              color: const Color(0xffF5E9B5),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
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
          MaterialPageRoute(
              builder: (context) => const ProductDetails(productId: '')),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // **Fruit Image Container**
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCCC9BC),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Image.asset(
                  fruit['image'],
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // **Fruit Name**
            Text(
              fruit['name'],
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            // **Price & MRP**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MRP: \u{20B9}${fruit['mrp']}',
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  '\u{20B9}${fruit['price']}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // **Discount**
            Text(
              '20% OFF',
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            // **Add Button**
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.white),
              iconSize: 28.sp,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

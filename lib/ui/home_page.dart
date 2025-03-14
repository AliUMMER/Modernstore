import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/fruites_page.dart';
import 'package:modern_grocery/ui/product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> slidingimage = [
    'assets/BANNER.png',
    'assets/BANNER 2.webp',
    'assets/Slider.png',
  ];

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
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Banana',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Banana.png'
    },
    {
      'name': 'Orange',
      'price': '₹90/kg',
      'rating': 3,
      'image': 'assets/Orange.png'
    },
    {
      'name': 'Strawberry',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/image 43.png'
    },
    {
      'name': 'Lemon',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/lemon.png'
    },
    {
      'name': 'Watermelon',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Watermelon.png'
    },
    {
      'name': 'Apple',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Apple.png'
    },
    {
      'name': 'Mango',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Mango.png'
    },
    {
      'name': 'Grapes',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Grapes.png'
    },
    {
      'name': 'Pappaya',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Pappaya.png'
    },
  ];
  final List<Map<String, dynamic>> Bevarages = [
    {
      'name': 'Mango Fruit Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Mango Fruit Drink.png'
    },
    {
      'name': '7up Soft Drink',
      'price': '₹90/kg',
      'rating': 3,
      'image': 'assets/7 up Soft Drinks.png'
    },
    {
      'name': 'Mirinda soft drink',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Mirinda Soft Drinks.png'
    },
    {
      'name': 'Sprite Soft drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Sprite Soft Drinks.png'
    },
    {
      'name': 'Drinking water',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Drinking Water.png'
    },
    {
      'name': 'Coco Cola Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Coco Cola Soft drink.png'
    },
    {
      'name': 'Litchi Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Litchi drink.png'
    },
    {
      'name': 'Real fruit drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Real Fruit Drink.png'
    },
    {
      'name': 'Perpsi Soft Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Pepsi Soft drink.png'
    },
  ];
  final List<Map<String, dynamic>> Vegitables = [
    {
      'name': 'Chilli Green',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Chilli Green.png'
    },
    {
      'name': 'Ladies Finger',
      'price': '₹90/kg',
      'rating': 3,
      'image': 'assets/Ladies Finger.png'
    },
    {
      'name': 'Parsely Leaves',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Parsely Leaves.png'
    },
    {
      'name': 'Potato',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Potato.png'
    },
    {
      'name': 'Onion',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Onion.png'
    },
    {
      'name': 'Green Beans',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Green Beans.png'
    },
    {
      'name': 'Cabage',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Cabage.png'
    },
    {
      'name': 'Egg Plant',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Egg Plant.png'
    },
    {
      'name': 'Carrot',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Carrot.png'
    },
    {
      'name': 'Tomato',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Tomato.png'
    },
    {
      'name': 'Curry Leaves',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Curry leaves.png'
    },
    {
      'name': 'GGarlic',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Garlic.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = slidingimage
        .map((item) => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ))
        .toList();
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55.h),

            /// Location and Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp,
                                  color: Color(0xffF5E9B5)),
                              SizedBox(width: 5.w),
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: Color(0xADFCF8E8),
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Tirur ITC road',
                                style: TextStyle(
                                  color: Color(0xFFFCF8E8),
                                  fontSize: 16.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Color(0xffF5E9B5)),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.favorite_outline, color: Color(0xffF5E9B5)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            CarouselSlider(
              items: slidingimage.map((imagePath) {
                return Image.asset(imagePath, fit: BoxFit.cover);
              }).toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),

            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Color(0xffFCF8E8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xffDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FruitesPage()),
                );
              },
              child: Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(0xffFCF8E8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                categories[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            categories[index]['name']!,
                            style: TextStyle(color: Color(0xffFCF8E8)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Deal',
                    style: TextStyle(
                      color: Color(0xffFCF8E8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xffDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),

            /// Horizontal Scroll for Best Deals
            SizedBox(
              height: 200, // Set height to ensure items fit well
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetails()),
                  );
                },
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: ProductCard(product: products[index]),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bevarages',
                    style: TextStyle(
                      color: Color(0xffFCF8E8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xffDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200, // Set height to ensure items fit well
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Bevarages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.w : 10.w, right: 10.w),
                    child: ProductCard(product: Bevarages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vegitables',
                    style: TextStyle(
                      color: Color(0xffFCF8E8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Color(0xffDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200, // Set height to ensure items fit well
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Vegitables.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.w : 10.w, right: 10.w),
                    child: vegitablecard(Vegitables: Vegitables[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Product Card Widget
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Fixed width for each product card
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFCF8E8), // Light background for image
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(product['image'], fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFfffff),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 18),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            product['name'],
            style: TextStyle(
                color: Color(0xffFCF8E8),
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < product['rating'] ? Icons.star : Icons.star_border,
                color: Colors.amberAccent,
                size: 14,
              );
            }),
          ),
          SizedBox(height: 5),
          Text(
            product['price'],
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class Bevaragecard extends StatelessWidget {
  final Map<String, dynamic> Bevarages;

  const Bevaragecard({super.key, required this.Bevarages});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Fixed width for each product card
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFCF8E8), // Light background for image
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Bevarages['image'], fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFfffff),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 18),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            Bevarages['name'],
            style: TextStyle(
                color: Color(0xffFCF8E8),
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < Bevarages['rating']
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amberAccent,
                size: 14,
              );
            }),
          ),
          SizedBox(height: 5),
          Text(
            Bevarages['price'],
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class vegitablecard extends StatelessWidget {
  final Map<String, dynamic> Vegitables;

  const vegitablecard({super.key, required this.Vegitables});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Fixed width for each product card
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFCF8E8), // Light background for image
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Vegitables['image'], fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFfffff),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 18),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            Vegitables['name'],
            style: TextStyle(
                color: Color(0xffFCF8E8),
                fontSize: 14,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < Vegitables['rating']
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amberAccent,
                size: 14,
              );
            }),
          ),
          SizedBox(height: 5),
          Text(
            Vegitables['price'],
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

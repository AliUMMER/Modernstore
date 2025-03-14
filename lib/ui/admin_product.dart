import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;

class AdminProduct extends StatefulWidget {
  const AdminProduct({super.key});

  @override
  State<AdminProduct> createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  final List<Map<String, dynamic>> fruits = [
    {
      'name': 'Banana',
      'image': 'assets/Banana.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Carrot',
      'image': 'assets/Carrot.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
    {
      'name': 'Onion',
      'image': 'assets/Onion.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': 'Papaya',
      'image': 'assets/Pappaya.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Potato',
      'image': 'assets/Potato.png',
      'price': 80,
      'mrp': 100,
      'rating': 2
    },
    {
      'name': 'Tomato',
      'image': 'assets/Tomato.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': 'Orange',
      'image': 'assets/Orange.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
  ];
  final List<Map<String, dynamic>> vegetables = [
    {
      'name': 'Chilli Green',
      'image': 'assets/Chilli Green.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
    {
      'name': 'Ladies Finger',
      'image': 'assets/Ladies Finger.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Parsely leaves',
      'image': 'assets/Parsely Leaves.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': 'Onion',
      'image': 'assets/Onion.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Potato',
      'image': 'assets/Potato.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
    {
      'name': 'Tomato',
      'image': 'assets/Tomato.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': 'Garlic',
      'image': 'assets/Garlic.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
  ];
  final List<Map<String, dynamic>> drinks = [
    {
      'name': 'Mango Fruit Drink',
      'image': 'assets/Mango Fruit Drink.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': '7up Soft Drink',
      'image': 'assets/7 up Soft Drinks.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Mirinda Soft Drink',
      'image': 'assets/Mirinda Soft Drinks.png',
      'price': 80,
      'mrp': 100,
      'rating': 3
    },
    {
      'name': 'Sprite',
      'image': 'assets/Sprite Soft Drinks.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Drinking Water',
      'image': 'assets/Drinking Water.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
    {
      'name': 'Pepsi',
      'image': 'assets/Pepsi Soft drink.png',
      'price': 80,
      'mrp': 100,
      'rating': 4
    },
    {
      'name': 'Real Fruit Drink',
      'image': 'assets/Real Fruit Drink.png',
      'price': 80,
      'mrp': 100,
      'rating': 5
    },
  ];

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add New Product',
            style: TextStyle(
              color: Color(0xFF3E7BFE),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFieldLabel('Name your product here',
                    fontSize: 16, color: const Color(0xFF898A8D)),
                _buildTextField(),
                _buildTextFieldLabel('Category'),
                _buildTextField(),
                _buildTextFieldLabel('Product Description'),
                _buildTextField(),
                _buildTextFieldLabel('Price'),
                _buildTextField(),
                _buildTextFieldLabel('Add Image'),
                _buildImageUploadField(),
                SizedBox(height: 15.h),
                _buildDialogActions(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 44.h),
              _buildAppBar(),
              SizedBox(height: 40.h),
              _buildSearchBar(),
              SizedBox(height: 40.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _showAddProductDialog,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5E9B5),
                      borderRadius: BorderRadius.circular(39),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add_circle_outline_outlined,
                            color: Colors.black),
                        SizedBox(width: 8.w),
                        const Text(
                          'Add Products',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 31.h),
              SizedBox(
                height: 262, // Set height to ensure items fit well
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: FruitCard(fruits: fruits[index]),
                    );
                  },
                ),
              ),
              SizedBox(height: 43.h),
              SizedBox(
                height: 262, // Set height to ensure items fit well
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: vegitablecard(vegetables: vegetables[index]),
                    );
                  },
                ),
              ),
              SizedBox(height: 43.h),
              SizedBox(
                height: 262, // Set height to ensure items fit well
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: drinkscard(drinks: drinks[index]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a labeled text field
  Widget _buildTextFieldLabel(String label,
      {double fontSize = 14, Color color = Colors.black}) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Builds a text input field with border
  Widget _buildTextField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFF909090)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// Builds an image upload field
  Widget _buildImageUploadField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFF909090)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/image gallery.svg', width: 37, height: 37),
          SizedBox(width: 10.w),
          const Text(
            '128564.jpg',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds Save and Cancel buttons for the dialog
  Widget _buildDialogActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5E9B5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(39)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Save Product',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF3E7BFE),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        badges.Badge(
          badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
          child: SvgPicture.asset('assets/Group.svg'),
        ),
        SizedBox(width: 24.w),
        SvgPicture.asset('assets/Group 6918.svg'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFCF8E8), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: Color(0x91FCF8E8), fontSize: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class FruitCard extends StatelessWidget {
  final Map<String, dynamic> fruits;

  const FruitCard({super.key, required this.fruits});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 180, // Slightly increased width for better spacing
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background for the card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150, // Slightly increased height
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      fruits['image'] ?? 'assets/default_image.png',
                      height: 76, // Adjusted image size for better fit
                      width: 94,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                fruits['name'] ?? 'Unknown Fruit',
                style: const TextStyle(
                  color: Color(0xffFCF8E8),
                  fontSize: 16, // Slightly larger for better readability
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 95,
              ),
              SvgPicture.asset('assets/product note.svg')
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (fruits['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: Color(0xffFFD500),
                size: 14,
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'MRP ₹${fruits['mrp'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: fruits['mrp'] != null && fruits['price'] != null
                          ? '${((1 - (fruits['price'] / fruits['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                          : 'Discount Unavailable',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class vegitablecard extends StatelessWidget {
  final Map<String, dynamic> vegetables;

  const vegitablecard({super.key, required this.vegetables});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 180, // Slightly increased width for better spacing
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background for the card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150, // Slightly increased height
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      vegetables['image'] ?? 'assets/default_image.png',
                      height: 76, // Adjusted image size for better fit
                      width: 94,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                vegetables['name'] ?? 'Unknown Fruit',
                style: const TextStyle(
                  color: Color(0xffFCF8E8),
                  fontSize: 16, // Slightly larger for better readability
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 75,
              ),
              SvgPicture.asset('assets/product note.svg')
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (vegetables['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: Color(0xffFFD500),
                size: 14,
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'MRP ₹${vegetables['mrp'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: vegetables['mrp'] != null &&
                              vegetables['price'] != null
                          ? '${((1 - (vegetables['price'] / vegetables['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                          : 'Discount Unavailable',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class drinkscard extends StatelessWidget {
  final Map<String, dynamic> drinks;

  const drinkscard({super.key, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 180, // Slightly increased width for better spacing
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background for the card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150, // Slightly increased height
                  width: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      drinks['image'] ?? 'assets/default_image.png',
                      height: 76, // Adjusted image size for better fit
                      width: 94,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                drinks['name'] ?? 'Unknown Fruit',
                style: const TextStyle(
                  color: Color(0xffFCF8E8),
                  fontSize: 16, // Slightly larger for better readability
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 55,
              ),
              SvgPicture.asset('assets/product note.svg')
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (drinks['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: Color(0xffFFD500),
                size: 14,
              );
            }),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'MRP ₹${drinks['mrp'] ?? 'N/A'}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: drinks['mrp'] != null && drinks['price'] != null
                          ? '${((1 - (drinks['price'] / drinks['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                          : 'Discount Unavailable',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

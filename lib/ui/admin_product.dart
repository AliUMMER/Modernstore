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
          title: Text(
            'Add New Product',
            style: TextStyle(
              color: const Color(0xFF3E7BFE),
              fontSize: 14.sp,
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
                    fontSize: 16.sp, color: const Color(0xFF898A8D)),
                _buildTextField(),
                _buildTextFieldLabel('Category', fontSize: 14.sp),
                _buildTextField(),
                _buildTextFieldLabel('Product Description', fontSize: 14.sp),
                _buildTextField(),
                _buildTextFieldLabel('Price', fontSize: 14.sp),
                _buildTextField(),
                _buildTextFieldLabel('Add Image', fontSize: 14.sp),
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
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
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
                      borderRadius: BorderRadius.circular(39.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_circle_outline_outlined,
                            color: Colors.black, size: 20.w),
                        SizedBox(width: 8.w),
                        Text(
                          'Add Products',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
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
                height: 270.h,
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
                height: 270.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vegetables.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: VegetableCard(vegetables: vegetables[index]),
                    );
                  },
                ),
              ),
              SizedBox(height: 43.h),
              SizedBox(
                height: 270.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: drinks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 20.w : 10.w, right: 10.w),
                      child: DrinksCard(drinks: drinks[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildTextField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: const Color(0xFF909090)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildImageUploadField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: const Color(0xFF909090)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/image gallery.svg',
              width: 37.w, height: 37.h),
          SizedBox(width: 10.w),
          Text(
            '128564.jpg',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5E9B5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(39.r)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Save Product',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: const Color(0xFF3E7BFE),
              fontSize: 12.sp,
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
          badgeContent:
              Text('3', style: TextStyle(color: Colors.white, fontSize: 10.sp)),
          child:
              SvgPicture.asset('assets/Group.svg', width: 24.w, height: 24.h),
        ),
        SizedBox(width: 24.w),
        SvgPicture.asset('assets/Group 6918.svg', width: 24.w, height: 24.h),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFCF8E8), width: 2.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(color: const Color(0x91FCF8E8), fontSize: 12.sp),
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
      height: 270.h,
      width: 190.w, // Increased width to accommodate content
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Image.asset(
                      fruits['image'] ?? 'assets/default_image.png',
                      height: 76.h,
                      width: 94.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115.h,
                  left: 50.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    fruits['name'] ?? 'Unknown Fruit',
                    style: TextStyle(
                      color: const Color(0xffFCF8E8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/product note.svg', width: 20.w),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (fruits['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: const Color(0xffFFD500),
                size: 14.w,
              );
            }),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'MRP ₹${fruits['mrp'] ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(text: ' ', style: TextStyle(fontSize: 12.sp)),
                      TextSpan(
                        text: fruits['mrp'] != null && fruits['price'] != null
                            ? '${((1 - (fruits['price'] / fruits['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                            : 'Discount Unavailable',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class VegetableCard extends StatelessWidget {
  final Map<String, dynamic> vegetables;

  const VegetableCard({super.key, required this.vegetables});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: 190.w, // Increased width to accommodate content
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Image.asset(
                      vegetables['image'] ?? 'assets/default_image.png',
                      height: 76.h,
                      width: 94.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115.h,
                  left: 50.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    vegetables['name'] ?? 'Unknown Vegetable',
                    style: TextStyle(
                      color: const Color(0xffFCF8E8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/product note.svg', width: 20.w),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (vegetables['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: const Color(0xffFFD500),
                size: 14.w,
              );
            }),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'MRP ₹${vegetables['mrp'] ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(text: ' ', style: TextStyle(fontSize: 12.sp)),
                      TextSpan(
                        text: vegetables['mrp'] != null &&
                                vegetables['price'] != null
                            ? '${((1 - (vegetables['price'] / vegetables['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                            : 'Discount Unavailable',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class DrinksCard extends StatelessWidget {
  final Map<String, dynamic> drinks;

  const DrinksCard({super.key, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: 190.w, // Increased width to accommodate content
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCF8E8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Image.asset(
                      drinks['image'] ?? 'assets/default_image.png',
                      height: 76.h,
                      width: 94.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 115.h,
                  left: 50.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    drinks['name'] ?? 'Unknown Drink',
                    style: TextStyle(
                      color: const Color(0xffFCF8E8),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset('assets/product note.svg', width: 20.w),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (drinks['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: const Color(0xffFFD500),
                size: 14.w,
              );
            }),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'MRP ₹${drinks['mrp'] ?? 'N/A'}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(text: ' ', style: TextStyle(fontSize: 12.sp)),
                      TextSpan(
                        text: drinks['mrp'] != null && drinks['price'] != null
                            ? '${((1 - (drinks['price'] / drinks['mrp'])) * 100).toStringAsFixed(0)}% OFF'
                            : 'Discount Unavailable',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

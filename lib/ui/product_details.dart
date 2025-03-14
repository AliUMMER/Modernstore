import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/ui/success_cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

double _rating = 4;

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 430.w,
              height: 396.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  color: Color(0xffDDDACB)),
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 31,
                      ),
                      BackButton(
                        color: Color(0xff000000),
                      ),
                      SizedBox(
                        width: 301,
                      ),
                      ImageIcon(AssetImage('assets/Vector.png'))
                    ],
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  Center(
                    child: Container(
                      height: 227,
                      width: 281,
                      child: Image(image: AssetImage('assets/Banana.png')),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Banana',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 35,
                        fontFamily: 'Poppins Medium',
                        fontWeight: FontWeight.w500,
                        height: 0.57,
                      ),
                    ),
                    SizedBox(
                      width: 214,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_outline,
                          color: Color(0xF2FCF8E8),
                        ))
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    const Text(
                      '₹80/kg',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 214),
                        _quantityButton('-', () {
                          setState(() {
                            if (count > 1) count--;
                          });
                        }),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CircleAvatar(
                              child: Text('$count',
                                  style: const TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            )),
                        _quantityButton('+', () {
                          setState(() {
                            count++;
                          });
                        }),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    const Text(
                      'Product detail',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 19,
                        fontFamily: 'Poppins Medium',
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 21),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Size - 500g',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Banana  is a fresh and high-quality fruits, known for its',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    const Text(
                      'rich flavor and versatility in various dishes. Weighing ',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      '500g, it is perfect for snacking, blending into smoothies,',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'or baking',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    SizedBox(
                      width: 32,
                    ),
                    const Text(
                      'Review',
                      style: TextStyle(
                        color: Color(0xF2FCF8E8),
                        fontSize: 19,
                        fontFamily: 'Poppins Medium',
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(
                      width: 202,
                    ),
                    RatingBar.builder(
                      itemSize: 20.0,
                      unratedColor: Color(0xF2FCF8E8),
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xffFFD500),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() => _rating = rating);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4E289),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuccessCart()),
                      );
                    },
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(String text, VoidCallback onPressed) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      child: IconButton(
        icon: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

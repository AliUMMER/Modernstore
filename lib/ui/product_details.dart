import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/AddToWishlist_bloc/add_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:modern_grocery/ui/success_cart.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;
  double _rating = 4;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCartBloc, AddCartState>(
      listener: (context, state) {
        if (state is AddCartLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessCart()),
          );
        } else if (state is AddCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Try Again'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AddCartLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  SizedBox(width: 20.w),
                  const Text('Processing...'),
                ],
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0909),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0.45.sh
                          : 0.35.sh,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Color(0xffDDDACB),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: const BackButton(color: Color(0xff000000)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: const ImageIcon(
                                AssetImage('assets/Vector.png')),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Container(
                          height: 0.25.sh,
                          width: 0.65.sw,
                          child: const Image(
                            image: AssetImage('assets/Banana.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Banana',
                            style: TextStyle(
                              color: const Color(0xF2FCF8E8),
                              fontSize: 28.sp,
                              fontFamily: 'Poppins Medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          BlocConsumer<AddToWishlistBloc, AddToWishlistState>(
                            listener: (context, state) {
                              if (state is AddToWishlistLoaded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Added to wishlist!")),
                                );
                              } else if (state is AddToWishlistError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Failed to add to wishlist")),
                                );
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  if (widget.productId.length == 24) {
                                    context.read<AddToWishlistBloc>().add(
                                        fetchAddToWishlistEvent(
                                            widget.productId));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Invalid Product ID")),
                                    );
                                  }
                                },
                                icon: state is AddToWishlistLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : Icon(
                                        state is AddToWishlistLoaded
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: const Color(0xF2FCF8E8),
                                        size: 24,
                                      ),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹80/kg',
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              _quantityButton('-', () {
                                setState(() {
                                  if (count > 1) count--;
                                });
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: Colors.grey[800],
                                  child: Text(
                                    '$count',
                                    style: TextStyle(
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              _quantityButton('+', () {
                                setState(() {
                                  count++;
                                });
                              }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Product detail',
                        style: TextStyle(
                          color: const Color(0xF2FCF8E8),
                          fontSize: 18.sp,
                          fontFamily: 'Poppins Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Size - 500g',
                        style: TextStyle(
                          color: const Color(0xF2FCF8E8),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Banana is a fresh and high-quality fruit, known for its rich flavor and versatility in various dishes. Weighing 500g, it is perfect for snacking, blending into smoothies, or baking.',
                        style: TextStyle(
                          color: const Color(0xF2FCF8E8),
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Review',
                            style: TextStyle(
                              color: const Color(0xF2FCF8E8),
                              fontSize: 18.sp,
                              fontFamily: 'Poppins Medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RatingBar.builder(
                            itemSize: 20.sp,
                            unratedColor: const Color(0xF2FCF8E8),
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
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
                      SizedBox(height: 40.h),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4E289),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            minimumSize: Size(0.8.sw, 48.h),
                          ),
                          onPressed: () {
                            context.read<AddCartBloc>().add(fetchAddCart());
                          },
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quantityButton(String text, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: Colors.black,
      child: IconButton(
        icon: Text(
          text,
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

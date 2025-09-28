import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/AddToWishlist_bloc/add_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/GetById/getbyid_bloc.dart';
import 'package:modern_grocery/bloc/addCart_bloc/add_cart_bloc.dart';
import 'package:modern_grocery/ui/cart_/success_cart.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;
  double _rating = 4.0;

  @override
  void initState() {
    super.initState();
    context.read<GetbyidBloc>().add(FetchGetbyid(widget.productId));
  }

  Widget _quantityButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        minimumSize: Size(40.w, 40.h),
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

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
              content: Text('Failed to add to cart. Try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<GetbyidBloc, GetbyidState>(
        builder: (context, state) {
          if (state is GetbyidLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is GetbyidLoaded) {
            final product = state.getByIdProduct;
            if (product == null || product.data == null) {
              return const Scaffold(
                body: Center(child: Text('Product data unavailable')),
              );
            }

            return Scaffold(
              backgroundColor: const Color(0xFF0A0909),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 1.sw,
                        height: 0.45.sh,
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
                                  child: const BackButton(color: Colors.black),
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
                              child: SizedBox(
                                height: 0.25.sh,
                                width: 0.65.sw,
                                child: Image.network(
                                  product.data!.images.isNotEmpty
                                      ? product.data!.images.first
                                      : 'https://modern-store-backend.onrender.com/image/uploads/products/placeholder.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/placeholder.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- Product info ---
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Wishlist
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.data!.name,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xF2FCF8E8),
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                BlocBuilder<AddToWishlistBloc,
                                    AddToWishlistState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        context.read<AddToWishlistBloc>().add(
                                            fetchAddToWishlistEvent(
                                                widget.productId));
                                      },
                                      icon: Icon(
                                        product.data!.inWishlist
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: const Color(0xF2FCF8E8),
                                        size: 24.sp,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // Price & Quantity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${product.data!.basePrice.toStringAsFixed(2)}/${product.data!.unit.toLowerCase()}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: CircleAvatar(
                                        radius: 20.r,
                                        backgroundColor: Colors.grey[800],
                                        child: Text(
                                          '$count',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _quantityButton('+', () {
                                      setState(() => count++);
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Details
                            Text(
                              'Product detail',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Category - ${product.data!.category.name}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              product.data!.description,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 24.h),

                            // Review
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Review',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                RatingBar.builder(
                                  itemSize: 20.sp,
                                  unratedColor: Colors.white24,
                                  initialRating: _rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
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

                            // Add to Cart Button
                            Center(
                              child: BlocBuilder<AddCartBloc, AddCartState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF4E289),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 40.w,
                                        vertical: 12.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      minimumSize: Size(0.8.sw, 48.h),
                                    ),
                                    onPressed: state is AddCartLoading
                                        ? null
                                        : () {
                                            context.read<AddCartBloc>().add(
                                                  FetchAddCart(
                                                      widget.productId, count),
                                                );
                                          },
                                    child: state is AddCartLoading
                                        ? SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.black),
                                            ),
                                          )
                                        : Text(
                                            'Add To Cart',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  );
                                },
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
            );
          }

          return const Scaffold(
            body: Center(child: Text("Unexpected error")),
          );
        },
      ),
    );
  }
}

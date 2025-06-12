import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/AddToWishlist_bloc/add_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/GetById/bloc/getbyid_bloc.dart';
import 'package:modern_grocery/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:modern_grocery/repositery/model/getByIdProduct.dart';
import 'package:modern_grocery/ui/success_cart.dart';

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
    print('Fetching product with ID: ${widget.productId}');
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
        style: TextStyle(
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
        } else if (state is AddCartLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  SizedBox(width: 20.w),
                  const Text('Adding to cart...'),
                ],
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<GetbyidBloc, GetbyidState>(
        builder: (context, state) {
          print('Current GetbyidBloc state: ${state.runtimeType}');
          if (state is GetbyidLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is GetbyidError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<GetbyidBloc>()
                            .add(FetchGetbyid(widget.productId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is GetbyidLoaded) {
            final product = state.getByIdProduct;
            if (product == null || product.data == null) {
              print('Product or product.data is null: $product');
              return const Scaffold(
                body: Center(child: Text('Product data is unavailable')),
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
                        width: double.infinity,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
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
                                  child: const BackButton(
                                      color: Color(0xff000000)),
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
                                child: Image.network(
                                  product.data!.images.isNotEmpty
                                      ? product.data!.images.first
                                      : 'https://modern-store-backend.onrender.com/image/uploads/products/placeholder.png',
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Image loading error: $error');
                                    return Image.asset(
                                      'assets/placeholder.png',
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.data!.name,
                                    style: TextStyle(
                                      color: const Color(0xF2FCF8E8),
                                      fontSize: 28.sp,
                                      fontFamily: 'Poppins Medium',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                BlocConsumer<AddToWishlistBloc,
                                    AddToWishlistState>(
                                  listener: (context, state) {
                                    if (state is AddToWishlistLoaded) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Added to wishlist!"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (state is AddToWishlistError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Failed to add to wishlist"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        if (widget.productId.length == 24) {
                                          context.read<AddToWishlistBloc>().add(
                                                fetchAddToWishlistEvent(
                                                    widget.productId),
                                              );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Invalid Product ID"),
                                              backgroundColor: Colors.red,
                                            ),
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
                                              product.data!.inWishlist
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              color: const Color(0xF2FCF8E8),
                                              size: 24,
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${product.data!.basePrice.toStringAsFixed(2)}/${product.data!.unit.toLowerCase()}',
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
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
                              'Category - ${product.data!.category.name}',
                              style: TextStyle(
                                color: const Color(0xF2FCF8E8),
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              product.data!.description,
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
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
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
                              child: BlocConsumer<AddCartBloc, AddCartState>(
                                listener: (context, state) {
                                  if (state is AddCartLoaded) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Added to cart!"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else if (state is AddCartError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Failed to add to cart"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
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
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.black),
                                            ),
                                          )
                                        : Text(
                                            'Add To Cart',
                                            style: TextStyle(
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

          print('Unknown state: $state');
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Unexpected state: ${state.runtimeType}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<GetbyidBloc>()
                          .add(FetchGetbyid(widget.productId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

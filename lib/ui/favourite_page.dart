import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_grocery/bloc/GetToWishlist_bloc/get_to_wishlist_bloc.dart';

import 'package:modern_grocery/repositery/model/getToWishlist_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late GetToWishlistModel data;

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget initializes
    BlocProvider.of<GetToWishlistBloc>(context).add(fetchGetToWishlistEvent());
  }

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
          BlocBuilder<GetToWishlistBloc, GetToWishlistState>(
            builder: (context, state) {
              if (state is GetToWishlistLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetToWishlistError) {
                return const Center(child: Text('Favorites not found'));
              }

              if (state is GetToWishlistLoaded) {
                final favourites = BlocProvider.of<GetToWishlistBloc>(context)
                    .getToWishlistModel;

                final wishlistItems = favourites.wishlists ?? [];

                if (wishlistItems.isEmpty) {
                  return const Center(child: Text('No favorites yet.'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: wishlistItems.length,
                    itemBuilder: (context, index) {
                      final item = wishlistItems[index];
                      return FavouriteItemCard(
                          item: item); // pass the model, not .toJson()
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          )

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Color(0xffF5E9B5),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //     ),
          //     onPressed: () {},
          //     child: const Center(
          //       child:
          //           Text('Add to Cart', style: TextStyle(color: Colors.black)),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class FavouriteItemCard extends StatelessWidget {
  final Wishlists item;

  const FavouriteItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = item.productId;
    final basePrice = product?.basePrice ?? 0;
    final discountPercentage = product?.discountPercentage ?? 0;
    final discountedPrice = basePrice - (basePrice * discountPercentage / 100);

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
              child: product?.images != null && product!.images!.isNotEmpty
                  ? Image.network(
                      product.images!.first,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported,
                            color: Colors.grey);
                      },
                    )
                  : const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? 'Unknown Product',
                    style: const TextStyle(
                      color: Color(0xFFFCF8E8),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'MRP ₹$basePrice',
                    style: const TextStyle(
                      color: Color(0xCEB4B2A9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (discountPercentage > 0)
                    Text(
                      '$discountPercentage% OFF',
                      style: const TextStyle(
                        color: Color(0xCE7FFC83),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  Text(
                    '₹${discountedPrice.toStringAsFixed(0)}',
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
              onPressed: () {
                // Add your delete functionality here
                // You can access item.id for the wishlist item ID
              },
            ),
          ],
        ),
      ),
    );
  }
}

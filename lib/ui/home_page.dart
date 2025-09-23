import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/GetAllBannerBloc/get_all_banner_bloc.dart';
import 'package:modern_grocery/bloc/GetAllCategories/bloc/get_all_categories_bloc.dart';
import 'package:modern_grocery/bloc/GetCategoryProducts/get_category_products_bloc.dart';
import 'package:modern_grocery/bloc/offerproduct/offerproduct_bloc.dart';
import 'package:modern_grocery/ui/products/fruites_page.dart';
import 'package:modern_grocery/ui/products/product_details.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget initializes
    BlocProvider.of<GetAllCategoriesBloc>(context).add(fetchGetAllCategories());
    BlocProvider.of<GetAllBannerBloc>(context).add(fetchGetAllBanner());
    BlocProvider.of<OfferproductBloc>(context).add(fetchOfferproductEvent());
    BlocProvider.of<GetCategoryProductsBloc>(context)
        .add(FetchCategoryProducts(categoryId: '67fb1aa6b49a18abdf26144e'));
    BlocProvider.of<GetCategoryProductsBloc>(context)
        .add(FetchCategoryProducts(categoryId: '67ec290adaa2fb3cd2af3a2a'));
  }

  // Local fallback data
  final List<Map<String, String>> localCategories = [
    {'name': 'Fruits', 'image': 'assets/Fruits.png'},
    {'name': 'Milk', 'image': 'assets/Milk.png'},
    {'name': 'Meats', 'image': 'assets/Meats.png'},
    {'name': 'Nuts', 'image': 'assets/Nuts.png'},
    {'name': 'Vegetables', 'image': 'assets/Vegetables.png'},
    {'name': 'Fancy', 'image': 'assets/Fancy.png'},
    {'name': 'Rice', 'image': 'assets/Rice.png'},
    {'name': 'Egg', 'image': 'assets/Egg.png'},
    {'name': 'Pet Food', 'image': 'assets/Pet Food.png'},
    {'name': 'Perfume', 'image': 'assets/Perfume.png'},
    {'name': 'Sanitary Pad', 'image': 'assets/Sanitary pads.png'},
    {'name': 'Bakery', 'image': 'assets/Bakery.png'},
    {'name': 'Gadget', 'image': 'assets/Gadget.png'},
    {'name': 'Beverages', 'image': 'assets/Beverages.png'},
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
      'name': 'Papaya',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Papaya.png'
    },
  ];

  final List<Map<String, dynamic>> beverages = [
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
      'name': 'Mirinda Soft Drink',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Mirinda Soft Drinks.png'
    },
    {
      'name': 'Sprite Soft Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Sprite Soft Drinks.png'
    },
    {
      'name': 'Drinking Water',
      'price': '₹90/kg',
      'rating': 5,
      'image': 'assets/Drinking Water.png'
    },
    {
      'name': 'Coca Cola Drink',
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
      'name': 'Real Fruit Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Real Fruit Drink.png'
    },
    {
      'name': 'Pepsi Soft Drink',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Pepsi Soft drink.png'
    },
  ];

  final List<Map<String, dynamic>> vegetables = [
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
      'name': 'Parsley Leaves',
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
      'name': 'Cabbage',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Cabage.png'
    },
    {
      'name': 'Eggplant',
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
      'name': 'Garlic',
      'price': '₹90/kg',
      'rating': 4,
      'image': 'assets/Garlic.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55.h),
            // Location and Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Location',
                            style: GoogleFonts.poppins(
                              color: const Color(0xADFCF8E8),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_sharp,
                              color: Color(0xFFF5E9B5)),
                          SizedBox(width: 5.w),
                          Text(
                            'Tirur ITC road',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFCF8E8),
                              fontSize: 16.sp,
                          
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: Color(0xFFF5E9B5)),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.favorite_outline, color: Color(0xFFF5E9B5)),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            // Banner Carousel
            BlocBuilder<GetAllBannerBloc, GetAllBannerState>(
              builder: (context, state) {
                if (state is GetAllBannerLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[900]!,
                    highlightColor: Colors.grey[800]!,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.h,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [1, 2, 3].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0.r),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
                if (state is GetAllBannerError) {
                  return Center(
                      child: Text('Failed to load banners',
                          style: GoogleFonts.poppins(color: Colors.white)));
                }
                if (state is GetAllBannerLoaded) {
                  final banner = BlocProvider.of<GetAllBannerBloc>(context)
                      .getAllBannerModel;
                  final bannerImages = banner.banners
                          ?.expand((banner) => banner.images ?? [])
                          .toList() ??
                      [];
                  return bannerImages.isNotEmpty
                      ? CarouselSlider(
                          items: bannerImages.map((imageUrl) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0.r),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 200.h,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      : Container(
                          height: 200.h,
                          color: Colors.grey[800],
                          child:  Center(
                              child: Text('No banners available',
                                  style: GoogleFonts.poppins(color: Colors.white))),
                        );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 40.h),
            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      'See All',
                      style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FruitesPage()),
                );
              },
              child: BlocBuilder<GetAllCategoriesBloc, GetAllCategoriesState>(
                builder: (context, state) {
                  if (state is GetAllCategoriesLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[900]!,
                      highlightColor: Colors.grey[800]!,
                      child: SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 20.w : 10.w, right: 10.w),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40.r,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: 60.w,
                                    height: 10.h,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  if (state is GetAllCategoriesError) {
                    return  Center(
                        child: Text('Failed to load categories',
                            style: GoogleFonts.poppins(color: Colors.white)));
                  }
                  if (state is GetAllCategoriesLoaded) {
                    final data = BlocProvider.of<GetAllCategoriesBloc>(context)
                        .getAllCategoriesModel;
                    return SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            data.categories?.length ?? localCategories.length,
                        itemBuilder: (context, index) {
                          final category = data.categories?[index];
                          final String categoryName =
                              category?.name ?? localCategories[index]['name']!;
                          final String imageUrl = category?.image ?? '';
                          final bool useLocalImage = imageUrl.isEmpty;

                          return Padding(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 20.w : 10.w, right: 10.w),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40.r,
                                  backgroundColor: const Color(0xFFFCF8E8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: useLocalImage
                                        ? Image.asset(
                                            localCategories[index]['image']!,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              localCategories[index]['image']!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  categoryName,
                                  style:
                                       GoogleFonts.poppins(color: Color(0xFFFCF8E8)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            // Best Deals Section
            BlocBuilder<OfferproductBloc, OfferproductState>(
              builder: (context, state) {
                if (state is OfferproductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OfferproductLoaded) {
                  final bestDeals = BlocProvider.of<OfferproductBloc>(context)
                      .offerproductModel;
                  print('bloc loaded successfully');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Best Deals',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFCF8E8),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child:  Text(
                                'See All',
                                style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bestDeals.data?.length,
                          itemBuilder: (context, index) {
                            final product = bestDeals.data![index];
                            // print(bestDeals.data!.length);

                            // // Debug prints to identify the issue
                            // print(
                            //     'Debug - product.name: ${product.name} (${product.name.runtimeType})');
                            // print(
                            //     'Debug - product.basePrice: ${product.basePrice} (${product.basePrice.runtimeType})');
                            // print(
                            //     'Debug - product.v: ${product.v} (${product.v.runtimeType})');
                            // print(
                            //     'Debug - product.images: ${product.images} (${product.images.runtimeType})');
                            // if (product.images?.isNotEmpty ?? false) {
                            //   print(
                            //       'Debug - first image: ${product.images![0]} (${product.images![0].runtimeType})');
                            // }

                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 20.w : 10.w, right: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                        productId: product.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ProductCard(
                                  product: {
                                    'name':
                                        (product.name ?? 'Unknown').toString(),
                                    'price': (product.basePrice ?? 0)
                                        .toString(), // Convert int to String
                                    'rating': product.v ?? 0,
                                    'image':
                                        (product.images?.isNotEmpty ?? false)
                                            ? product.images![0].toString()
                                            : 'assets/placeholder.png',
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is OfferproductError) {
                  return  Center(
                      child: Text('Failed to load best deals',
                          style: GoogleFonts.poppins(color: Colors.white)));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            // Beverages Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Beverages',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      'See All',
                      style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<GetCategoryProductsBloc, GetCategoryProductsState>(
              builder: (context, state) {
                if (state is GetCategoryProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetCategoryProductsLoaded) {
                  final beverages = context
                      .read<GetCategoryProductsBloc>()
                      .getCategoryProductsModel;

                  // Check if data exists and is not empty
                  if (beverages.data == null || beverages.data!.isEmpty) {
                    return const Text("No beverages available");
                  }

                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: beverages.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 20.w : 10.w,
                            right: 10.w,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    productId: beverages.data![index].id ?? '',
                                  ),
                                ),
                              );
                            },
                            // Fix: Access the list item from beverages.data
                            child: ProductCard(
                                product: beverages.data![index].toJson()),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is GetCategoryProductsError) {
                  return const Text("Failed to load beverages");
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            // Vegetables Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vegetables',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFCF8E8),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      'See All',
                      style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<GetCategoryProductsBloc, GetCategoryProductsState>(
              builder: (context, state) {
                if (state is GetCategoryProductsLoading) {
                  return SizedBox(
                    height: 200.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is GetCategoryProductsLoaded) {
                  final vegetables = context
                      .read<GetCategoryProductsBloc>()
                      .getCategoryProductsModel;

                  // Check if data exists and is not empty
                  if (vegetables.data == null || vegetables.data!.isEmpty) {
                    return SizedBox(
                      height: 200.h,
                      child:  Center(
                        child: Text(
                          "No vegetables available",
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: vegetables.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 20.w : 10.w,
                            right: 10.w,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    // Pass the actual product ID
                                    productId: vegetables.data![index].id ?? '',
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              product: vegetables.data![index].toJson(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is GetCategoryProductsError) {
                  return SizedBox(
                    height: 200.h,
                    child:  Center(
                      child: Text(
                        "Failed to load vegetables",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 200.h,
                    child: const SizedBox.shrink(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Product Card Widget
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
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
                    color: const Color(0xFFFCF8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      product['image'] ?? 'assets/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.add, color: Colors.black, size: 18),
                      onPressed: () {
                        // Add to cart logic here
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            product['name'] ?? 'Unknown',
            style: GoogleFonts.poppins(
              color: const Color(0xFFFCF8E8),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return Icon(
                starIndex < (product['rating'] ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amberAccent,
                size: 14.sp,
              );
            }),
          ),
          SizedBox(height: 5.h),
          Text(
            product['price'] ?? '₹0',
            style: GoogleFonts.poppins(color: const Color(0xFFFFFFFF), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

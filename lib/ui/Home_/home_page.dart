import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_grocery/bloc/Banner_/GetAllBannerBloc/get_all_banner_bloc.dart';

import 'package:modern_grocery/bloc/Categories_/GetAllCategories/get_all_categories_bloc.dart';
import 'package:modern_grocery/bloc/Categories_/GetCategoryProducts/get_category_products_bloc.dart';
import 'package:modern_grocery/bloc/Product_/offerproduct/offerproduct_bloc.dart';
import 'package:modern_grocery/localization/app_localizations.dart';
import 'package:modern_grocery/services/language_service.dart';
import 'package:modern_grocery/ui/products/fruites_page.dart';
import 'package:modern_grocery/ui/products/product_details.dart';
import 'package:modern_grocery/widgets/app_color.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onFavTap;

  const HomePage({super.key, this.onFavTap});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currrentBanner = 0;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        final lang = languageService.currentLanguage;
        
        return Scaffold(
          backgroundColor: const Color(0xFF0A0909),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 55.h),
                // Location and Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.getString('location', lang),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xADFCF8E8),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: Color(0xFFF5E9B5),
                                    size: 22.sp,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Tirur ITC road', // Keep this as is since it's location specific
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFCF8E8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down,
                                      color: Color(0xFFF5E9B5)),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              if (widget.onFavTap != null) {
                                widget.onFavTap!();
                              }
                            },
                            icon: Icon(
                              Icons.favorite_outline,
                              color: Color(0xFFF5E9B5),
                              size: 22.sp,
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 18.h),
                      // Search Bar
                      SizedBox(
                        height: 48.h,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.getString('search_something', lang),
                            hintStyle: GoogleFonts.poppins(
                                color: AppConstants.primaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                            prefixIcon:
                                Icon(Icons.search, color: Color(0x91FCF8E8)),
                            filled: true,
                            fillColor: Color(0xFF0A0909),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryText, width: 2.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryText, width: 2.w),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryText, width: 2.w),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 13.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 63.h),
                // Banner Carousel
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: Column(
                    children: [
                      // Banner section
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
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          }

                          if (state is GetAllBannerError) {
                            return Container(
                              height: 200.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(8.0.r),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 40.sp,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      AppLocalizations.getString('failed_load_banners', lang),
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      state.errorMessage.contains('Authentication')
                                          ? AppLocalizations.getString('please_login', lang)
                                          : AppLocalizations.getString('try_again_later', lang),
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[400],
                                        fontSize: 12.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (state is GetAllBannerLoaded) {
                            final banner = state.banner;
                            final bannerImages = banner.banners
                                    ?.expand((b) => b.images ?? [])
                                    .toList() ??
                                [];

                            return Column(
                              children: [
                                bannerImages.isNotEmpty
                                    ? Column(
                                        children: [
                                          CarouselSlider(
                                            items: bannerImages.map((imageUrl) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0.r),
                                                child: CachedNetworkImage(
                                                  imageUrl: imageUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    color: Colors.grey[800],
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.image_not_supported,
                                                        color: Colors.grey[400],
                                                        size: 50.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: Colors.grey[900]!,
                                                    highlightColor:
                                                        Colors.grey[800]!,
                                                    child: Container(
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                              height: 222.h,
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 0.8,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  const Duration(milliseconds: 800),
                                              autoPlayCurve: Curves.fastOutSlowIn,
                                              enlargeCenterPage: true,
                                              enlargeFactor: 0.3,
                                              scrollDirection: Axis.horizontal,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  _currrentBanner = index;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 22.h),

                                          // Indicator Dots
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: bannerImages
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              return GestureDetector(
                                                onTap: () => setState(() {
                                                  _currrentBanner = entry.key;
                                                }),
                                                child: Container(
                                                  width:
                                                      _currrentBanner == entry.key
                                                          ? 10.w
                                                          : 6.w,
                                                  height: 6.h,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8.h,
                                                      horizontal: 3.w),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        _currrentBanner == entry.key
                                                            ? Colors.white
                                                            : Colors.grey,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        height: 200.h,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.getString('no_banners', lang),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                // Categories Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.getString('categories', lang),
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFCF8E8),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.getString('see_all', lang),
                          style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.h),
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
                        return Center(
                            child: Text(AppLocalizations.getString('failed_load_categories', lang),
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
                                    SizedBox(height: 11.h),
                                    Text(
                                      categoryName,
                                      style: GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFCF8E8)),
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.getString('best_deals', lang),
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFCF8E8),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.getString('see_all', lang),
                          style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 26.h),

                BlocBuilder<OfferproductBloc, OfferproductState>(
                  builder: (context, state) {
                    if (state is OfferproductLoading) {
                      return _buildshimmer();
                    }

                    if (state is OfferproductLoaded) {
                      final bestDeals = BlocProvider.of<OfferproductBloc>(context)
                          .offerproductModel;
                      print('bloc loaded successfully');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bestDeals.data?.length,
                              itemBuilder: (context, index) {
                                final product = bestDeals.data![index];
                                
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
                                            (product.name ?? AppLocalizations.getString('unknown', lang)).toString(),
                                        'price': (product.basePrice ?? 0)
                                            .toString(),
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
                      return Center(
                          child: Text(AppLocalizations.getString('failed_load_deals', lang),
                              style: GoogleFonts.poppins(color: Colors.white)));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                // Beverages Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.getString('beverages', lang),
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFCF8E8),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.getString('see_all', lang),
                          style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 26.h),

                BlocBuilder<GetCategoryProductsBloc, GetCategoryProductsState>(
                  builder: (context, state) {
                    if (state is GetCategoryProductsLoading) {
                      return _buildshimmer();
                    } else if (state is GetCategoryProductsLoaded) {
                      final beverages = context
                          .read<GetCategoryProductsBloc>()
                          .getCategoryProductsModel;

                      // Check if data exists and is not empty
                      if (beverages.data == null || beverages.data!.isEmpty) {
                        return Text(AppLocalizations.getString('no_beverages', lang),
                            style: GoogleFonts.poppins(color: Colors.white));
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
                                child: ProductCard(
                                    product: beverages.data![index].toJson()),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is GetCategoryProductsError) {
                      return Center(
                          child: Text(AppLocalizations.getString('failed_load_beverages', lang),
                              style: GoogleFonts.poppins(color: Colors.white)));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

                // Vegetables Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.getString('vegetables', lang),
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFCF8E8),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.getString('see_all', lang),
                          style: GoogleFonts.poppins(color: Color(0xFFDDD2A3)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 26.h),
                BlocBuilder<GetCategoryProductsBloc, GetCategoryProductsState>(
                  builder: (context, state) {
                    if (state is GetCategoryProductsLoading) {
                      return _buildshimmer();
                    } else if (state is GetCategoryProductsLoaded) {
                      final vegetables = context
                          .read<GetCategoryProductsBloc>()
                          .getCategoryProductsModel;

                      // Check if data exists and is not empty
                      if (vegetables.data!.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.getString('no_vegetables', lang),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
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
                      return Center(
                        child: Text(
                          AppLocalizations.getString('failed_load_vegetables', lang),
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Reusable Product Card Widget remains the same
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
            style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

Widget _buildshimmer() {
  return SizedBox(
    height: 200.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 20.w : 10.w,
            right: 10.w,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[700]!,
            child: Container(
              width: 140.w,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
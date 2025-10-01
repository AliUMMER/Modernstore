import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:modern_grocery/bloc/Categories_/GetAllCategories/get_all_categories_bloc.dart';

import 'package:modern_grocery/repositery/model/GetAllCategoriesModel.dart';
import 'package:modern_grocery/services/language_service.dart'; // Add this import
import 'package:modern_grocery/ui/products/fruites_page.dart';
import 'package:modern_grocery/widgets/app_color.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback? onFavTap;
  const SearchPage({super.key, this.onFavTap});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late GetAllCategoriesModel data;
  int selectedIndex = 0;
  late LanguageService languageService; // Add this line

  @override
  void initState() {
    super.initState();
    languageService = LanguageService(); // Initialize the service
    BlocProvider.of<GetAllCategoriesBloc>(context).add(fetchGetAllCategories());
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0909),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 72.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Center(
              child: Text(
                languageService.getString('find_products'), // Localized text
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  color: AppConstants.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppConstants.secondaryText, width: 2.w),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextField(
                style: GoogleFonts.poppins(color: Color(0x91FCF8E8)),
                decoration: InputDecoration(
                  hintText: languageService.getString('search_something'), // Localized text
                  hintStyle: GoogleFonts.poppins(
                      color: AppConstants.primaryText, fontSize: 14.sp),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0x91FCF8E8)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 14.h),
                ),
              ),
            ),
            SizedBox(height: 36.h),
            BlocBuilder<GetAllCategoriesBloc, GetAllCategoriesState>(
                builder: (context, state) {
              if (state is GetAllCategoriesLoading) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[900]!,
                  highlightColor: Colors.grey[800]!,
                  child: Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  ),
                );
              }
              if (state is GetAllCategoriesError) {
                return Center(
                    child: Text(
                        languageService.getString('categories_not_recognized'), // Localized text
                        style: GoogleFonts.poppins(color: Colors.white)));
              }
              if (state is GetAllCategoriesLoaded) {
                data = BlocProvider.of<GetAllCategoriesBloc>(context)
                    .getAllCategoriesModel;
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: data.categories!.map((category) {
                      return _buildCategoryCard(
                        category.name ?? languageService.getString('no_name'), // Localized text
                        category.image ?? 'no image',
                      );
                    }).toList(),
                  ),
                );
              } else {
                return SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FruitesPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.primaryText,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl ?? 'https://via.placeholder.com/80',
              height: 74.h,
              width: 104.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image);
              },
            ),
            SizedBox(height: 13.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
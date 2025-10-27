import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart'; // Keep for other widgets
// import 'package:http/http.dart'; // http seems unused, can be removed if not needed elsewhere
import 'package:image_picker/image_picker.dart';
import 'package:modern_grocery/bloc/Banner_/DeleteBanner_bloc/delete_banner_bloc.dart';
import 'package:modern_grocery/bloc/Banner_/GetAllBannerBloc/get_all_banner_bloc.dart';
// --- Adjust this import path as needed ---

// ------------------------------------------
import 'package:modern_grocery/ui/admin/admin_profile.dart';
import 'package:modern_grocery/ui/admin/upload_recentpage.dart';
import 'package:modern_grocery/widgets/app_color.dart';
import 'package:modern_grocery/widgets/fontstyle.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<GetAllBannerBloc>(context).add(fetchGetAllBanner());
      }
    });
  }

  int _currrentBanner = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909), // Kept original color
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            _buildAppBar(),
            SizedBox(height: 40.h),
            _buildSearchBar(),
            SizedBox(height: 40.h),
            _buildbanner(),
            SizedBox(height: 20.h),
            _buildSummaryCards(),
            SizedBox(height: 20.h),
            _buildStatsContainer(),
            SizedBox(height: 20.h),
            _buildTopCategoriesChart(),
            SizedBox(height: 20.h),
            _buildMonthlyOrdersChart(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- UNCHANGED ---
  Widget _buildAppBar() {
    return Row(
      children: [
        Spacer(),
        badges.Badge(
          badgeContent: Text('3',
              style: fontStyles.bodyText2.copyWith(color: Colors.white)),
          child: SvgPicture.asset('assets/Group.svg'),
        ),
        SizedBox(width: 24.w),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminProfile(),
                  ));
            },
            child: SvgPicture.asset('assets/Group 6918.svg')),
      ],
    );
  }

  //
  // [--- THIS SECTION IS MODIFIED ---]
  //
  Widget _buildbanner() {
    return Column(
      children: [
        BlocBuilder<GetAllBannerBloc, GetAllBannerState>(
          builder: (context, state) {
            if (state is GetAllBannerLoaded) {
              final banner = state.banner;
              if (banner.banners.isEmpty) {
                return Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // Kept original color
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: Center(
                    // --- Refactored Style ---
                    child: Text('No Banners Found',
                        style: fontStyles.primaryTextStyle
                            .copyWith(color: appColor.textColor2)),
                  ),
                );
              }
              final bannerImg = banner.banners.toList();

              return Column(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    items: bannerImg.map((bannerItem) {
                      // Renamed imageUrl to bannerItem
                      final String url = (bannerItem.images.isNotEmpty)
                          ? bannerItem.images[0]
                          : "";

                      if (url.isEmpty || !url.startsWith('http')) {
                        return _buildErrorImage(); // Assuming _buildErrorImage is updated below
                      }

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorWidget: (context, url, error) =>
                                  _buildErrorImage(),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[900]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(color: Colors.grey[800]),
                              ),
                            ),
                          ),
                          // --- Delete button passed the correct ID ---
                          Positioned(
                            top: 8.h,
                            right: 8.w, // Positioned top-right
                            child: _buildbannerDelete(
                                bannerItem.id, context), // Pass context
                          ),
                        ],
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 222.h,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: bannerImg.length > 1,
                      reverse: false,
                      autoPlay: bannerImg.length > 1,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        if (mounted) {
                          // Added mounted check
                          setState(() {
                            _currrentBanner = index;
                          });
                        }
                      },
                    ),
                  ),
                  // Positioned removed from here
                  SizedBox(height: 22.h),
                  if (bannerImg.length > 1)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: AnimatedSmoothIndicator(
                        activeIndex: _currrentBanner,
                        count: bannerImg.length,
                        effect: WormEffect(
                          dotHeight: 8.h,
                          dotWidth: 8.w,
                          spacing: 5.w,
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey,
                        ),
                        onDotClicked: (index) {
                          _carouselController.animateToPage(index);
                        },
                      ),
                    ),
                ],
              );
            } else if (state is GetAllBannerError) {
              return Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Kept original color
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          color: appColor.errorColor, size: 40.sp),
                      SizedBox(height: 10.h),
                      // --- Refactored Style ---
                      Text("Failed to load banners",
                          style: fontStyles.errorstyle
                              .copyWith(color: appColor.textColor2)),
                    ],
                  ),
                ),
              );
            } else {
              // Loading state
              return SizedBox(
                height: 222.h,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[900]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
  // [--- END OF MODIFIED SECTION ---]

  // --- UNCHANGED ---
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 41.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFCF8E8), width: 2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TextField(
              style: GoogleFonts.poppins(color: const Color(0x91FCF8E8)),
              decoration: InputDecoration(
                hintText: "Search here",
                hintStyle: GoogleFonts.poppins(
                    color: const Color(0x91FCF8E8), fontSize: 12.sp),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    // Pop dialog first
                    Navigator.of(context).pop();
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null && mounted) {
                      // check mounted
                      print('Selected image: ${pickedFile.path}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecentPage(imagePath: pickedFile.path),
                        ),
                      );
                    } else {
                      print('No image selected or widget unmounted.');
                    }
                  },
                  child: Container(
                    width: 383
                        .w, // Consider making this responsive or removing fixed width
                    height: 222.h,
                    padding: EdgeInsets.all(20.w), // Added padding
                    decoration: BoxDecoration(
                      color: const Color(0xFF3C3C3C),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    // Use Column for better layout in Dialog
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/upload.svg',
                            height: 40.h), // Adjusted size
                        SizedBox(height: 12.h),
                        Text(
                          "Add A Banner Image",
                          style: GoogleFonts.poppins(
                            // Kept original style here
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "optimal dimensions 383*222",
                          style: GoogleFonts.poppins(
                            // Kept original style here
                            color: Colors.grey.shade300,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        // Using Icon as visual cue, original Stack/Positioned removed
                        Icon(Icons.add_circle,
                            color: Colors.white, size: 30.sp),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child:
              SvgPicture.asset('assets/upload.svg'), // Kept original icon here
        ),
      ],
    );
  }

  // --- UNCHANGED ---
  Widget _buildSummaryCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(width: 16),
          SummaryCard(title: 'Total Orders', value: '520', icon: Icons.list),
          SizedBox(width: 16),
          SummaryCard(
              title: 'Total Customers', value: '520', icon: Icons.people),
          SizedBox(width: 16),
          SummaryCard(
              title: 'Total Categories', value: '14', icon: Icons.grid_view),
          SizedBox(width: 16),
          SummaryCard(
              title: 'Total Revenue',
              value: '\u20B925800', // Consider formatting currency
              icon: Icons.credit_card),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  // --- UNCHANGED ---
  Widget _buildStatsContainer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff292727),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              StatCard(
                label: 'New Orders',
                value: '54',
                icon: Icons.receipt_long,
              ),
              StatCard(
                label: 'Out for Delivery',
                value: '60',
                icon: Icons.local_shipping,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(color: Color(0xffFFFFFF)), // Consider lighter color
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              StatCard(
                label: 'Delivered',
                value: '78',
                icon: Icons.delivery_dining,
              ),
              StatCard(
                label: 'Cancelled',
                value: '20',
                icon: Icons.cancel,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- UNCHANGED ---
  Widget _buildTopCategoriesChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Categories',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: PieChart(PieChartData(sections: _getPieChartData())),
        ),
      ],
    );
  }

  // --- UNCHANGED ---
  Widget _buildMonthlyOrdersChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Orders Monthly',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: BarChart(
            BarChartData(
              barGroups: _getBarChartData(),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30.h, // Added reserved size
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toInt()) {
                        case 0:
                          text = 'Jan';
                          break;
                        case 1:
                          text = 'Feb';
                          break;
                        case 2:
                          text = 'Mar';
                          break;
                        case 3:
                          text = 'Apr';
                          break;
                        // Add more cases as needed
                      }
                      return Text(
                        text,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12.sp),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40.w, // Added reserved size
                    getTitlesWidget: (value, meta) {
                      // Show labels at intervals
                      if (value % 50 != 0 && value != 0) return Container();
                      return Text(
                        value.toInt().toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12.sp),
                      );
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),
      ],
    );
  }

  // --- UNCHANGED ---
  List<PieChartSectionData> _getPieChartData() {
    // Consider adding dynamic data and percentages
    return [
      PieChartSectionData(
          value: 50,
          title: 'Vegetables',
          color: Colors.green,
          radius: 60.r), // Added radius
      PieChartSectionData(
          value: 25, title: 'Fruits', color: Colors.orange, radius: 60.r),
      PieChartSectionData(
          value: 15, title: 'Meats', color: Colors.red, radius: 60.r),
      PieChartSectionData(
          value: 10, title: 'Other', color: Colors.blue, radius: 60.r),
    ];
  }

  // --- UNCHANGED ---
  List<BarChartGroupData> _getBarChartData() {
    // Consider adding dynamic data
    final double barWidth = 16.w; // Define bar width
    final BorderRadius borderRadius =
        BorderRadius.circular(4.r); // Define border radius
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
            toY: 150,
            color: Colors.white,
            width: barWidth,
            borderRadius: borderRadius)
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
            toY: 180,
            color: Colors.white,
            width: barWidth,
            borderRadius: borderRadius)
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
            toY: 120,
            color: Colors.white,
            width: barWidth,
            borderRadius: borderRadius)
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(
            toY: 200,
            color: Colors.white,
            width: barWidth,
            borderRadius: borderRadius)
      ]),
    ];
  }
} // End of _DashboardState

// --- UNCHANGED ---
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key, // Added key
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: const Color(0xffFCF8E8), // Consider using appColor
          borderRadius: BorderRadius.circular(12.r), // Use .r
          boxShadow: [
            // Added subtle shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold, // Consider adjusting weight
            ),
            maxLines: 1, // Prevent overflow
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align items vertically
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20.sp, // Consider adjusting size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(icon, color: Colors.black, size: 24.sp), // Use .sp
            ],
          ),
        ],
      ),
    );
  }
}

// --- UNCHANGED ---
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
    super.key, // Added key
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white, // Consider Colors.white70
            fontSize: 14.sp,
            fontWeight: FontWeight.bold, // Consider adjusting weight
          ),
          maxLines: 1, // Prevent overflow
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h), // Consider reducing space
        Row(
          children: [
            // Consider placing Icon first
            Text(
              value,
              style: GoogleFonts.poppins(
                color: const Color(0xffF5E9B5), // Consider appColor.textColor
                fontSize: 20.sp, // Consider adjusting size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(icon, color: Colors.white, size: 24.sp), // Use .sp
          ],
        ),
      ],
    );
  }
}

// --- MODIFIED Error Image Widget ---
Widget _buildErrorImage() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[800], // Kept original color
      borderRadius: BorderRadius.circular(8.0.r),
    ),
    child: Center(
      // Center content
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined, // Changed icon
            color: Colors.grey[400],
            size: 50.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            'Image Load Failed', // Changed text
            // --- Refactored Style ---
            style: fontStyles.errorstyle2.copyWith(
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center, // Center text
          ),
        ],
      ),
    ),
  );
}

// --- MODIFIED Delete Banner Widget ---
Widget _buildbannerDelete(String bannerId, BuildContext context) {
  return InkWell(
    // Use InkWell for better tap feedback
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: appColor.backgroundColor, // Use appColor
            // --- Refactored Style ---
            title: Text('Delete Banner?',
                style:
                    fontStyles.heading2.copyWith(color: appColor.textColor2)),
            // --- Refactored Style ---
            content: Text('Are you sure you want to delete this banner?',
                style: fontStyles.primaryTextStyle
                    .copyWith(color: appColor.textColor2)),
            actions: [
              TextButton(
                // --- Refactored Style ---
                child: Text('Cancel',
                    style: fontStyles.bodyText
                        .copyWith(color: appColor.textColor)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                // --- Refactored Style ---
                child: Text('Delete',
                    style: fontStyles.bodyText
                        .copyWith(color: appColor.errorColor)),
                onPressed: () {
                  BlocProvider.of<DeleteBannerBloc>(context)
                      .add(fetchDeleteBannerEvent(BnnerId: bannerId));
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    },
    child: Container(
      height: 32.h, // Larger tap area
      width: 32.w,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Semi-transparent black
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.delete_outline,
          color: appColor.errorColor, size: 18.sp), // Use outlined icon
    ),
  );
}

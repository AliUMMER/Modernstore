import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
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
            _buildSummaryCards(),
            SizedBox(height: 20.h),
            _buildStatsContainer(),
            SizedBox(height: 20.h),
            _buildTopCategoriesChart(),
            SizedBox(height: 20.h),
            _buildMonthlyOrdersChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        SizedBox(width: 316.w),
        badges.Badge(
          badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
          child: SvgPicture.asset('assets/Group.svg'),
        ),
        SizedBox(width: 24.w),
        SvgPicture.asset('assets/Group 6918.svg'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 41.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFCF8E8), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: TextStyle(color: const Color(0x91FCF8E8)),
              decoration: InputDecoration(
                hintText: "Search here",
                hintStyle:
                    TextStyle(color: const Color(0x91FCF8E8), fontSize: 12.sp),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        SvgPicture.asset('assets/filter.svg'),
      ],
    );
  }

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
              value: '\u20B925800',
              icon: Icons.credit_card),
          SizedBox(width: 16),
        ],
      ),
    );
  }

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
          const Divider(color: Color(0xffFFFFFF)),
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

  Widget _buildTopCategoriesChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Categories',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: PieChart(PieChartData(sections: _getPieChartData())),
        ),
      ],
    );
  }

  Widget _buildMonthlyOrdersChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Orders Monthly',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: BarChart(
            BarChartData(
              barGroups: _getBarChartData(),
              borderData: FlBorderData(show: false), // Hide border
              gridData: FlGridData(show: false), // Hide grid
              titlesData: FlTitlesData(
                show: true, // Show axis titles
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Customize x-axis labels
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
                      }
                      return Text(
                        text,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Customize y-axis labels
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Hide right axis
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Hide top axis
                ),
              ),
              barTouchData:
                  BarTouchData(enabled: false), // Disable touch interaction
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _getPieChartData() {
    return [
      PieChartSectionData(value: 50, title: 'Vegetables', color: Colors.green),
      PieChartSectionData(value: 25, title: 'Fruits', color: Colors.orange),
      PieChartSectionData(value: 15, title: 'Meats', color: Colors.red),
      PieChartSectionData(value: 10, title: 'Other', color: Colors.blue),
    ];
  }

  List<BarChartGroupData> _getBarChartData() {
    return [
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 150, color: Colors.white)]),
      BarChartGroupData(
          x: 1, barRods: [BarChartRodData(toY: 180, color: Colors.white)]),
      BarChartGroupData(
          x: 2, barRods: [BarChartRodData(toY: 120, color: Colors.white)]),
      BarChartGroupData(
          x: 3, barRods: [BarChartRodData(toY: 200, color: Colors.white)]),
    ];
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
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
        color: const Color(0xffFCF8E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: Colors.black,
                size: 24.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: const Color(0xffF5E9B5),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              icon,
              color: Colors.white,
              size: 24.w,
            ),
          ],
        ),
      ],
    );
  }
}

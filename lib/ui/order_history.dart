import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  // Sample data for the order history
  final List<Map<String, String>> orderHistoryData = [
    {
      'invoiceNumber': 'GR/KTK/025',
      'date': '26/03/2025 10:00 AM',
      'name': 'Adhil PM',
      'qty': '4',
      'amount': '510.00',
      'orderDetails': 'Order Details',
    },
    {
      'invoiceNumber': 'GR/KTK/026',
      'date': '25/03/2025 09:00 AM',
      'name': 'John Doe',
      'qty': '2',
      'amount': '250.00',
      'orderDetails': 'Order Details',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0A0909),
      body: Column(
        children: [
          SizedBox(height: 44.h),
          _buildAppBar(),
          SizedBox(height: 40.h),
          _buildSearchBar(),
          SizedBox(height: 20.h),
          _buildOrderHistoryList(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        Spacer(), // Uses available space to push items to the right
        badges.Badge(
          badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
          position: badges.BadgePosition.topEnd(top: 0, end: 3),
          child: SvgPicture.asset('assets/Group.svg'),
        ),
        SizedBox(width: 16),
        IconButton(
          icon: SvgPicture.asset('assets/Group 6918.svg'),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search here",
                hintStyle: TextStyle(color: const Color(0x91FCF8E8)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xFFFCF8E8), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xFFFCF8E8), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          SvgPicture.asset('assets/filter.svg')
        ],
      ),
    );
  }

  Widget _buildOrderHistoryList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: orderHistoryData.length,
        itemBuilder: (context, index) {
          final order = orderHistoryData[index];
          return Card(
            color: Colors.white.withOpacity(0.1),
            margin: EdgeInsets.only(bottom: 16.h),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Invoice Number and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invoice Number: ${order['invoiceNumber']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order['date']!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Name
                  Text(
                    'Name: ${order['name']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Quantity and Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Qty: ${order['qty']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Amount: \$${order['amount']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Order Details
                  Text(
                    'Order Details: ${order['orderDetails']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Print Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add print functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                      ),
                      child: Text(
                        'Print',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminStock extends StatefulWidget {
  const AdminStock({super.key});

  @override
  _AdminStockState createState() => _AdminStockState();
}

class _AdminStockState extends State<AdminStock> {
  // Example Firestore reference

  final List<Map<String, String>> products = [
    {
      'slNo': '1',
      'productName': 'Mango',
      'unitPrice': '90',
      'units': 'Kilo Gram',
      'qtyInStock': '100 Kg',
      'soldQty': '80 Kg',
      'inventoryValue': '9000',
      'salesValue': '7200',
      'remainingStock': '20 Kg',
      'reorderStatus': 'Low',
    },
    {
      'slNo': '2',
      'productName': 'Banana',
      'unitPrice': '80',
      'units': 'Kilo Gram',
      'qtyInStock': '150 Kg',
      'soldQty': '50 Kg',
      'inventoryValue': '4500',
      'salesValue': '3500',
      'remainingStock': '50 Kg',
      'reorderStatus': 'Good',
    },
    {
      'slNo': '3',
      'productName': 'Apple',
      'unitPrice': '120',
      'units': 'Kilo Gram',
      'qtyInStock': '200 Kg',
      'soldQty': '120 Kg',
      'inventoryValue': '24000',
      'salesValue': '14400',
      'remainingStock': '80 Kg',
      'reorderStatus': 'Medium',
    },
    {
      'slNo': '4',
      'productName': 'Onion',
      'unitPrice': '40',
      'units': 'Kilo Gram',
      'qtyInStock': '150 Kg',
      'soldQty': '130 Kg',
      'inventoryValue': '5200',
      'salesValue': '4000',
      'remainingStock': '20 Kg',
      'reorderStatus': 'Low',
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
          SizedBox(height: 73.h),
          Expanded(child: _buildInventoryTable()), // Corrected placement
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
        ],
      ),
    );
  }

  Widget _buildInventoryTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 100,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.black), // Background color for header
        dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.black), // Row background color
        border: TableBorder.all(color: Color(0xFFF5E9B5)),
        columns: [
          DataColumn(
            label: Text('SL No', style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Product Name',
                style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label:
                Text('Unit Price', style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Units', style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Qty In Stock',
                style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Sold Qty', style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Inventory Value',
                style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label:
                Text('Sales Value', style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Remaining Stock',
                style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
          DataColumn(
            label: Text('Reorder Status',
                style: TextStyle(color: Color(0xFFF5E9B5))),
          ),
        ],
        rows: products.map((product) {
          return DataRow(cells: [
            DataCell(
                Text(product['slNo']!, style: TextStyle(color: Colors.white))),
            DataCell(Text(product['productName']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['unitPrice']!,
                style: TextStyle(color: Colors.white))),
            DataCell(
                Text(product['units']!, style: TextStyle(color: Colors.white))),
            DataCell(Text(product['qtyInStock']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['soldQty']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['inventoryValue']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['salesValue']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['remainingStock']!,
                style: TextStyle(color: Colors.white))),
            DataCell(Text(product['reorderStatus']!,
                style: TextStyle(color: Colors.white))),
          ]);
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/admin_product.dart';
import 'package:modern_grocery/ui/admin_stock.dart';
import 'package:modern_grocery/ui/dashboard.dart';
import 'package:modern_grocery/ui/order_history.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminNavibar extends StatefulWidget {
  const AdminNavibar({super.key});

  @override
  State<AdminNavibar> createState() => _AdminNavibarState();
}

class _AdminNavibarState extends State<AdminNavibar> {
  int _selectedIndex = 0;

  final List<Widget> _listOfWidgets = <Widget>[
    Dashboard(),
    AdminProduct(),
    AdminStock(),
    OrderHistory(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E9B5),
      body: _listOfWidgets[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFFF5E9B5), // Sets the background to transparent
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Vector (2).svg'),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Vector (1).svg'),
              label: 'Stock',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Vector.svg'),
              label: 'Order History',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          elevation: 8,
        ),
      ),
    );
  }
}

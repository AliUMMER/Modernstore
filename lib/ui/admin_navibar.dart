import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_grocery/ui/admin_category.dart';
import 'package:modern_grocery/ui/admin_product.dart';
import 'package:modern_grocery/ui/admin_stock.dart';
import 'package:modern_grocery/ui/dashboard.dart';
import 'package:modern_grocery/ui/order_history.dart';

class AdminNavibar extends StatefulWidget {
  const AdminNavibar({super.key});

  @override
  State<AdminNavibar> createState() => _AdminNavibarState();
}

class _AdminNavibarState extends State<AdminNavibar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Dashboard(),
    AdminProduct(),
    AdminCategory(),
    AdminStock(),
    OrderHistory(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem({
    required String assetPath,
    required String label,
    required bool isSelected,
    IconData? fallbackIcon,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        color: isSelected ? Colors.black : Colors.grey,
        placeholderBuilder: (context) => Icon(
            fallbackIcon ?? Icons.image_not_supported,
            color: isSelected ? Colors.black : Colors.grey),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E9B5),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xffF5E9B5),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Dashboard',
            ),
            _buildNavItem(
              assetPath: 'assets/ap.svg',
              label: 'Product',
              isSelected: _selectedIndex == 1,
              fallbackIcon: Icons.shopping_bag,
            ),
            _buildNavItem(
              assetPath: 'assets/Vector (2).svg',
              label: 'Category',
              isSelected: _selectedIndex == 2,
              fallbackIcon: Icons.category,
            ),
            _buildNavItem(
              assetPath: 'assets/Vector (1).svg',
              label: 'Stock',
              isSelected: _selectedIndex == 3,
              fallbackIcon: Icons.inventory,
            ),
            _buildNavItem(
              assetPath: 'assets/Vector.svg',
              label: 'Orders',
              isSelected: _selectedIndex == 4,
              fallbackIcon: Icons.receipt_long,
            ),
          ],
        ),
      ),
    );
  }
}

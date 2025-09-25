import 'package:flutter/material.dart';
import 'package:modern_grocery/ui/cart_/cart_page.dart';
import 'package:modern_grocery/ui/Home_/favourite_page.dart';
import 'package:modern_grocery/ui/Home_/home_page.dart';
import 'package:modern_grocery/ui/Home_/profile_page.dart';
import 'package:modern_grocery/ui/Home_/search_page.dart';
import 'package:modern_grocery/widgets/app_color.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;
  late PageController _pageController;
  int _lastvisitedpageIndex = 0;
  int _currentpageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.textColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            if (_currentpageIndex != index) {
              _lastvisitedpageIndex = _currentpageIndex;
            }
            _currentpageIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), // disable swipe
        children: [
          HomePage(
            onFavTap: () {
              _onItemTapped(2);
            },
          ),
          SearchPage(
            onFavTap: () {
              _onItemTapped(2);
            },
          ),
          FavouritePage(
            onFavTap: () {
              _onItemTapped(3);
            },
          ),
          CartPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppConstants.textColor),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'Profile'),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0x80000000),
          currentIndex: _currentpageIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          elevation: 8,
        ),
      ),
    );
  }
}

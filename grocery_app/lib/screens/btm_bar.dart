import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_screen.dart';
import 'package:grocery_app/screens/category.dart';
import 'package:grocery_app/screens/homepage.dart';
import 'package:grocery_app/screens/user.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
// ignore: unused_import
import '../consts/theme_data.dart';
import '../provider/dark_theme_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const Homepage(), 'title': "HomePage"},
    {'page': Categories(), 'title': "Category"},
    {'page': const Cart(), 'title': "Cart"},
    {'page': const User(), 'title': "User"},
  ];
  void _selectedPage(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(title: Text(_pages[_selectedIndex]['title']),),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: themeState.getDarkTheme
              ? Theme.of(context).cardColor
              : Colors.white,
          currentIndex: _selectedIndex,
          onTap: _selectedPage,
          unselectedItemColor: _isDark ? Colors.white : Colors.black12,
          selectedItemColor:
              _isDark ? Colors.lightBlue.shade400 : Colors.black87,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: badges.Badge(
                  showBadge: true,
                    badgeContent: const Text("1",style: TextStyle(color: Colors.white),),                    
                    badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
                    child: Icon(_selectedIndex == 2
                        ? IconlyBold.buy
                        : IconlyLight.buy)),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: 'Category'),
          ]),
    );
  }
}

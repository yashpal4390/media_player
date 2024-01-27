// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:media_player/Controller/media_provider.dart';
import 'package:media_player/View/FirstPage.dart';
import 'package:media_player/View/favorite_page.dart';
import 'package:media_player/main.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Player"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (isBottomSheetOpen == false) {
              _currentIndex = index;
            }
          },
          physics: (isBottomSheetOpen == true)
              ? NeverScrollableScrollPhysics() // Disable scrolling when the bottom sheet is open
              : PageScrollPhysics(),
          children: const [
            FirstPage(),
            MyHomePage(title: "title2"),
            FavoritePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (isBottomSheetOpen == false) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

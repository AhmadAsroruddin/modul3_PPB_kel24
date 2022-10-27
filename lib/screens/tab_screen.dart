import 'package:flutter/material.dart';
import 'package:percobaan/screens/home.dart';
import './profilePage.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int SelectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      SelectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': HomePage(), 'title': 'My Anime List'},
      {'page': Profile(), 'title': 'Our Profile'},
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[SelectedPageIndex]['title']),
      ),
      body: _pages[SelectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        selectedItemColor: Colors.white,
        currentIndex: SelectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
              label: "My Anime List"),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite_outline),
              label: "Our Profile")
        ],
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ipcv_assignment/recomandations.dart';
import 'home.dart';




class BottomNav extends StatefulWidget {
  final List<CameraDescription> cameras;
  final apiKey;

  BottomNav({required this.cameras,required this.apiKey, Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Articles'),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(cameras: widget.cameras);
      case 1:
        return Recommendations(apiKey: widget.apiKey);
      default:
        return HomeScreen(cameras: widget.cameras); // Default to HomeScreen
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

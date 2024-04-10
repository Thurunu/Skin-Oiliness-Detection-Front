import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


import 'bottombar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras =await availableCameras();

  final apiKey = "AIzaSyDK9Lod8vtpLzt0tMIxgA3ct6YAArR-k34";


  runApp(shinespy(cameras: cameras, apiKey: apiKey,));
}

class shinespy extends StatelessWidget {
  final List<CameraDescription> cameras;
  final apiKey;
  const shinespy({required this.cameras,required this.apiKey, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: BottomNav(cameras: cameras, apiKey: apiKey,),
    );
  }
}
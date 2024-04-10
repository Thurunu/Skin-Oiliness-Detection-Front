import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera/camerascreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showCamera = false; // State variable to manage camera visibility


  @override
  Widget build(BuildContext context) {
    TextEditingController levelController = TextEditingController(); // Controller for the TextField

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          child: contentBox(context, levelController), // Pass the controller to the contentBox function
        ),
      ),
    );
  }

  Widget contentBox(BuildContext context, TextEditingController levelController) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black, // Ensures the container's background is black
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Best Way to Find Your Skin Oiliness',
                  textAlign: TextAlign.center, // Centers the text
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 20),
                _showCamera
                    ? Container( // Camera preview container
                  width: 270,
                  height: 270,
                  child: CameraScreen(cameras: widget.cameras),
                  // child: Icon(
                  // Icons.camera_alt,
                  // size: 100,
                  // color: Colors.white,
                )

                    : Container( // Placeholder container for the camera icon
                  width: 270,
                  height: 270,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showCamera = !_showCamera; // Toggle camera visibility
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => const CameraScreen()),
                    //   );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEFE8A2), // Button color
                  ),
                  child: Text(
                    _showCamera ? 'Close Camera' : 'Open Camera',
                    style: TextStyle(fontSize: 18.0, color: Color(0xFF000000)),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(height: 30),
                Text(
                  'Your oiliness level is',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 20),
                // TextField for inputting the level
                TextField(
                  controller: levelController, // Assign the controller
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFEFE8A2)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter your level",
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: 'Level',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.number, // Assuming level is a number
                ),
                SizedBox(height: 30),
                Text(
                  'To get the detailed report',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeTest extends StatefulWidget {
  const NativeTest({Key? key}) : super(key: key);

  @override
  _NativeTestState createState() => _NativeTestState();
}

class _NativeTestState extends State<NativeTest> {
  static const platform = MethodChannel('example.com/value');

  String _deviceInfo = "Unkoown Device";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Flutter Example',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(
          _deviceInfo,
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future<void> _getDeviceInfo() async{
    String deviceInfo = _deviceInfo;

    try {
      final String result = await platform.invokeMethod('getDeviceInfo') as String;
      deviceInfo = result;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

}

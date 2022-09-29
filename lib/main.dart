
import 'package:flutter/material.dart';
import 'package:flutter_example/bookList.dart';
import 'package:flutter_example/complexUiTest.dart';
import 'package:flutter_example/nativeTest.dart';
import 'package:flutter_example/obesityCalculExample.dart';
import 'package:flutter_example/pageViewMapTest.dart';
import 'package:flutter_example/storeList.dart';
import 'package:flutter_example/timerTest.dart';
import 'package:flutter_example/todoTest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';


// 앱 시작 부분
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// 시작 클래스(머터리얼 디자인 앱 생성)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 표시할 화면의 인스턴스(상단바)
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // 현재 위치 여부
  Location location = Location();

  MyHomePage({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('복잡한 UI 만들기'),
              onPressed: () {
                //await Navigator.pushNamed(context, '/complexUi');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ComplexUiExample()),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ObesityCalCulExample()),
                  );
                },
                child: const Text('비만도 계산기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TimerExample()),
                );
             },
              child: const Text('스톱워치'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodoExample()),
                );
              },
              child: const Text('할 일 관리'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookList()),
                );
              },
              child: const Text('책 정보 받아오기(API)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NativeTest()),
                );
              },
              child: const Text('Native 연동하기'),
            ),
            ElevatedButton(
              onPressed: () async {
                LocationData? locationData;
                print('경도 : ${locationData?.longitude}');
                print('위도 : ${locationData?.latitude}');

                // 현재 위치 여부를 파악
                if(locationData == null || locationData.longitude == null && locationData.latitude == null) {
                  // 현재 위치가 없는 경우 위치 서비스 활성화 여부 파악
                  String message = "";
                  Map<Permission, PermissionStatus> status = await [Permission.location].request();
                  if(!await Permission.location.isGranted) {
                    print('위치 권한 미허용');
                    message = '위치 서비스 비활성화 상태로 매장명 가나다순으로 매장 목록을 표시합니다.';
                  } else {
                    print('위치 권한 허용');
                    message = 'GPS 신호를 찾을 수 없어 매장명 가나다 순으로 매장 목록을 표시합니다.';
                  }
                  showPopUp(context, message);
                } else {
                  // 현재 위치가 있는 경우 매장 리스트 화면으로 이동
                  moveStoreList(context);
                }
              },
              child: const Text('매장 리스트'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageViewMapTest()),
                );
              },
              child: const Text('PageView 및 지도 예제'),
            ),
          ],
        ),
      ),
    );
  }

  showPopUp(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          content: Text(
            message,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 8.0,
          contentPadding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          buttonPadding: const EdgeInsets.all(30.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0),
            ),
          ),
          actions: [
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  // 다이얼로그 팝업 닫은 후 매장 리스트 화면으로 이동
                  Navigator.pop(context);

                  moveStoreList(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                      color: Colors.white,

                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0),
                      ),
                    )
                ),
                child: Text('확인'),
              ),
            ),
          ],
        );
      },
    );
  }

  // 매장 리스트 화면으로 이동
  moveStoreList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const StoreListExample()),
    );
  }
}

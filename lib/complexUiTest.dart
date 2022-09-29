
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';


class ComplexUiExample extends StatefulWidget {
  const ComplexUiExample({Key? key}) : super(key: key);

  @override
  _ComplexUiExampleState createState() => _ComplexUiExampleState();
}

class _ComplexUiExampleState extends State<ComplexUiExample> {
  // 페이지 인덱
  var _index = 0;
  var _pages = [HomePage(), ServicePage(), InfoPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('복잡한 UI'),
        trailing: IconButton(
          icon: Icon(Icons.add),
          iconSize: 30,
          onPressed: () {
            // 상단 add 클릭이벤
          },
        ),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
          // _index = index;
          //
          // StatelessWidget 에서 setState() 동작을 실핼하고자 하는 경우
          //(context as Element).markNeedsBuild();
        },
        // 선택된 인덱스
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '이용서비스',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: '내정보',
          ),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          _buildTop(),
          _buildMiddle(),
          _buildBottom(),
        ],
      );
  }

  // 상단부분
  Widget _buildTop() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('택시'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('블랙'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('바이크'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('대리'),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('택시'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('블랙'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.local_taxi_sharp,
                  size: 40,
                ),
                Text('바이크'),
              ],
            ),
            Opacity(
              opacity: 0.0,
              child: Container(
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildMiddle() {
    final mDummyData = [
      'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        // 슬라이더가 자동으로 넘어가가도록 설
        autoPlay: true,
      ),
      items: mDummyData.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    print('아이템 클릭');
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom() {
    final itemList = List.generate(
      10,
          (index) => ListTile(
        title: Text('[이벤트] 이것은 $index번째 공지사항입니다.'),
        leading: Icon(Icons.notifications),
      ),
    );
    return ListView(
      scrollDirection:Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: itemList,
    );
  }
}

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('이용서비스'),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('내정보'),
    );
  }
}



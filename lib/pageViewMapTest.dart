import 'dart:async';

import 'package:flutter/material.dart';

class PageViewMapTest extends StatefulWidget {
  const PageViewMapTest({Key? key}) : super(key: key);

  @override
  _PageViewMapTestState createState() => _PageViewMapTestState();
}

class _PageViewMapTestState extends State<PageViewMapTest> with SingleTickerProviderStateMixin{
  late PageController _pageController;
  late TabController _tabController;
  late StreamController _streamController;
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this);
    _streamController = StreamController<int>()..add(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _tabController.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView & Map Test'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) {
            page = value;
            _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
          tabs: const [
            Tab(icon: Icon(Icons.map),),
            Tab(icon: Icon(Icons.list),),
          ],
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              // page = value;
              // _tabController.animateTo(page, duration: Duration(milliseconds: 300), curve: Curves.ease);
              _streamController.add(value);
            },
            children: [
              _buildContainer(1, Colors.red),
              _buildContainer(2, Colors.blue),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: 50,
              child: StreamBuilder<dynamic>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (snapshot.data == index) ? Colors.white : Colors.grey
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Container _buildContainer(int page, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          'Page $page',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerExample extends StatefulWidget {
  const TimerExample({Key? key}) : super(key: key);

  @override
  _TimerExampleState createState() => _TimerExampleState();
}

class _TimerExampleState extends State<TimerExample> {
  Timer? _timer;
  var _time = 0;
  var _isRunning = false;

  List<String> _lapTime = [];


  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('StopWatch'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('재생/일시정지');

          _isRunning = !_isRunning;
          if(_isRunning) {
            _start();
          } else {
            _pause();
          }
        },
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    var sec = _time ~/ 100;
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$sec', style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                    ),
                    Text('$hundredth', style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 300,
                  child: ListView(
                    children: _lapTime.map((time) => Text(time)).toList(),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () {
                  print('초기화');

                  setState(() {
                    _isRunning = false;
                    _timer?.cancel();
                    _lapTime.clear();
                    _time = 0;
                  });
                },
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ElevatedButton(
                onPressed: () {
                  print('랩타임');

                  String time = '$sec.$hundredth';
                  _lapTime.insert(0, '${_lapTime.length + 1}등 $time');

                },
                child: Text('랩타임'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  _pause() {
    _timer?.cancel();
  }
}

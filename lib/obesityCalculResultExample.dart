import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ObesityCalCulResultExample extends StatelessWidget {
  final double height;
  final double weight;

  ObesityCalCulResultExample(this.height, this.weight);

  @override
  Widget build(BuildContext context) {
    final double bmi = weight / ((height / 100) * (height / 100));
    print('$bmi');

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('비만도 계산 결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getBmiResult(bmi)),
            getBmiIcon(bmi),
          ],
        ),
      ),
    );
  }

  getBmiResult(double bmi) {
    String result;
    if (35 <= bmi) {
      result = '고도 비만';
    } else if(30 <= bmi) {
      result = '2단계 비만';
    } else if(25 <= bmi) {
      result = '1단계 비만';
    } else if(23 <= bmi) {
      result = '과체중';
    } else if(18.5 <= bmi) {
      result = '정상';
    } else {
      result = '저체중';
    }
    return result;
  }

  getBmiIcon(double bmi) {
    if(23 <= bmi) {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if(18.5 <= bmi) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    } else {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,
      );
    }
  }
}

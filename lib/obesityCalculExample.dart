

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/obesityCalculResultExample.dart';


class ObesityCalCulExample extends StatefulWidget {
  const ObesityCalCulExample({Key? key}) : super(key: key);

  @override
  _ObesityCalCulExampleState createState() {
    return _ObesityCalCulExampleState();
  }
}

class _ObesityCalCulExampleState extends State<ObesityCalCulExample> {
  // Form 위젯에 유니크한 키값을 부여하고 검증 시 사용
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if(value != null) {
                    if (value.isEmpty) {
                      return '키를 입력해주세요.';
                    } else if (value.length < 2){
                      return '키를 2자리 이상 입력해주세요.';
                    }
                  }
                  return null;
                },
                controller: _heightController,
                decoration: InputDecoration(
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                validator: (value) {
                  if(value != null) {
                    if (value.isEmpty) {
                      return '몸무게를 입력해주세요.';
                    } else if (value.length < 2){
                      return '몸무게를 2자리 이상 입력해주세요.';
                    }
                  }
                  return null;
                },
                controller: _weightController,
                decoration: InputDecoration(
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  // 결과 화면으로 이동
                  if(_formKey.currentState!.validate()) {
                    // 검증 성공
                    double inputHeight = double.parse(_heightController.text.trim());
                    double inputWeight = double.parse(_weightController.text.trim());

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ObesityCalCulResultExample(
                          inputHeight,
                          inputWeight),
                      ),
                    );
                  } else {
                    print('검증 실패');
                  }
                },
                child: Text('결과'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


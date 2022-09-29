

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/sirenOrderStoreListRes.dart';
import 'package:flutter_example/paramDefine.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sirenOrderStoreListRes.dart';

class StoreListExample extends StatefulWidget {
  const StoreListExample({Key? key}) : super(key: key);

  @override
  _StoreListExampleState createState() => _StoreListExampleState();
}

class _StoreListExampleState extends State<StoreListExample> {
  final List<String> shortcutList = ['리저브', 'DT', 'W/T', 'Delivers', 'Eco'];
  static const platform = MethodChannel('example.com/value');
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<StoreList>? storeList;
  bool isNearStore = true;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = jsonDecode(ParamDefine.JSON_DATA);
    var sirenOrderStoreListRes  = SirenOrderStoreListRes.fromJson(map);
    storeList = sirenOrderStoreListRes.app?.storeList;
    print('${sirenOrderStoreListRes.app?.totalCount}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            '매장 설정',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 7.0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.qr_code,
                color: Colors.black54,
              ),
              onPressed: () {
                print('qr코드 클릭');
              },
            ),
            IconButton(
              onPressed: () {
                print('지도 클릭');
              },
              icon: const Icon(
                Icons.map_outlined,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _searchController,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      Fluttertoast.showToast(
                        msg: '검색어를 입력해주세요.',
                        backgroundColor: Colors.blue,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: '검색',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Color(0xf7f7f7),
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _buildShortCutItem(),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  children: [
                    TextButton(
                      child: isNearStore ? const Text('가까운 매장', style: TextStyle(fontWeight: FontWeight.bold),) : Text('가까운 매장'),
                      onPressed: () {
                        print('가까운 매장 선택');

                        setState(() {
                          print('가까운 매장 setState()');
                          isNearStore = true;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 15,
                      color: Colors.black54,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                    ),
                    TextButton(
                      child: isNearStore ? const Text('자주 가는 매장') : const Text('자주 가는 매장', style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: () {
                        print('자주 가는 매장 선택');

                        setState(() {
                          print('자주 가는 매장 setState()');
                          isNearStore = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),

              isNearStore ? _buildStoreItem(sirenOrderStoreListRes.app!.storeList) : _buildNoStore(),
            ],
          ),
        ),
      ),
    );
  }

  // ShortCut 리스트 구현
  Widget _buildShortCutItem() {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shortcutList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(right: 5.0),
                height: 30,
                child: OutlinedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  icon: const Icon(
                    Icons.drive_eta,
                    color: Colors.black54,
                  ),
                  label: Text(
                    shortcutList[index],
                    style: const TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    print('${shortcutList[index]} 클릭');
                    getSirenOrderStoreList();
                  },
                ),
              );
            }
        ));
  }

  /// 자주 가는 매장
  Widget _buildNoStore() {
    print('_buildNoStore() called.');
    return Expanded(
      flex: 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('자주 가는 매장이 없습니다.'),
        ],
      ),
    );
  }

  /// 매장 리스트
  Widget _buildStoreItem(List<StoreList>? storeList) {
    print('_buildStoreItem() called. ');
    return Expanded(
      flex: 9,
      child: ListView.builder(
          itemCount: storeList!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print('매장 선택');

                showStoreDetailView(storeList[index]);
              },
              child: Container(
                height: 100,
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        storeList[index].storeImgUrl!,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text('${storeList[index].storeName!}점',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Flexible(
                                  child: Text(storeList[index].storeAddr!,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                child: Text(
                                  getDistance(storeList[index].distance),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  String getDistance(String? distance) {
    String changeDistance = "";
    if(distance == null) {
      return changeDistance;
    }
    bool isMeter = double.parse(distance) < ParamDefine.DISTANCE_1KM;
    double doubleDistance = double.parse(distance);
    changeDistance = isMeter ? '${doubleDistance.toStringAsFixed(0)}m' : '${(doubleDistance * 0.001).toStringAsFixed(0)}km';
    return changeDistance;
  }

  /**
   * 매장 상세 팝업
   */
  void showStoreDetailView(StoreList store) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 24, right: 24),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        store.storeImgUrl!,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(store.storeName!, maxLines: 2, style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: store.storeAddr!,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black54,
                          size: 24.0,
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.access_time,
                              color: Colors.black54,
                              size: 24.0,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('사이렌 오더 운영 시간', style: TextStyle(fontSize: 16, color: Colors.black54),),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('ㄴ 카페  ${store.openTime} - ${store.closeTime}', style: TextStyle(fontSize: 16, color: Colors.black54),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(top: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('오시는 길', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('${store.outsideStoreDesc}', style: TextStyle(fontSize: 16, color: Colors.black54),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<SirenOrderStoreListRes?> getSirenOrderStoreList() async {
    print('getSirenOrderStoreList() called.');

    String url = 'https://dev-msr.istarbucks.co.kr:6443/appif_new7/xo/sirenOrderStoreList.do';
    String osVersion = '';
    String appVersion = '';
    String userAgent = '';

    try {
      osVersion = await platform.invokeMethod('getOsVersion') as String;
      appVersion = await platform.invokeMethod('getAppVersion') as String;
      userAgent = await platform.invokeMethod('getUserAgent') as String;
    } catch (e) {
      print(e.toString());
    }
    print(
        'osVersion : ${osVersion}, appVersion : ${appVersion}, userAgent : ${userAgent}');

    var bodyData = jsonEncode({
      'app': {
        'gbn': 'C',
        'latitude': '37.5610642',
        'longitude': '126.9826067',
        'page': '1',
        'stockCheckYn': 'N'
      }
    });
    print(bodyData);
    //
    // http.Response response = await http.post(
    //     Uri.parse(url), headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Accept': 'application/json',
    //   'osType': 'android',
    //   'osVersion': '${osVersion}',
    //   'appVersion': '92.5.1',
    //   'model': 'SM-G950N',
    //   'User-Agent': 'Starbucks_Android/92.3.0.2(Android:9)',
    //   'msgVersion': '4',
    // }, body: bodyData);
    //
    // print('statusCode : ${response.statusCode}');
    // print(response.headers.toString());

    FormData formData = FormData.fromMap({
      'app': {
        'gbn': 'C',
        'latitude': '37.5610642',
        'longitude': '126.9826067',
        'page': '1',
        'stockCheckYn': 'N',
        'contentType': 'application/json; charset=UTF-8',
      }
    });

    try {
      Dio dio = Dio();
      dio.options.contentType = 'application/x-www-form-urlencoded';
      dio.options.contentType = Headers.formUrlEncodedContentType;
      Response response = await dio.post(url, data: formData, options: Options(headers: {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'osType': 'android',
        'osVersion': '${osVersion}',
        'appVersion': '92.5.1',
        'model': 'SM-G950N',
        'User-Agent': 'Starbucks_Android/92.3.0.2(Android:9)',
        'msgVersion': '4',
      }));

      if(response.statusCode == 200) {
        print('response 200 success');
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('error message : ' + e.toString());
    }
  }
}

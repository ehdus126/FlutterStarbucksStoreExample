import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  String? result = "";
  List? data;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = new List.empty(growable: true);
    textEditingController.addListener(() {
      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
        print('Bottom');
        page++;
        getJsonData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: '검색어를 입력하세요.',
            ),
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0 ?
          Text(
            '데이터가 없습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ) : ListView.builder(itemCount: data!.length, itemBuilder: (context, index) {
             return Card(
               child: Container(
                 child: Column(
                   children: <Widget> [
                     Text(data![index]['title'].toString()),
                     Text(data![index]['authors'].toString()),
                     Text(data![index]['sale_price'].toString()),
                     Text(data![index]['status'].toString()),
                     Image.network(
                       data![index]['thumbnail'],
                       height: 100,
                       width: 100,
                     fit: BoxFit.contain,
                     ),
                   ],
                 ),
               ),
             );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var url = 'http://www.google.com';
          // var response = await http.get(Uri.parse(url));
          // setState(() {
          //   result = response.body;
          // });
          page = 1;
          data!.clear();
          getJsonData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJsonData() async {
    var url = "https://dapi.kakao.com/v3/search/book?target=title&query=${textEditingController.text}}";
    var response = await http.get(Uri.parse(url), headers: {"Authorization" : "KakaoAK 89d8db7914a2b17dbe2f95dbddfade67"});
    print(response.body);

    setState(() {
      var dataConvertedToJson = json.decode(response.body);
      List result = dataConvertedToJson['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}

class TodoExample extends StatefulWidget {
  const TodoExample({Key? key}) : super(key: key);

  @override
  _TodoExampleState createState() => _TodoExampleState();
}

class _TodoExampleState extends State<TodoExample> {
  final _formKey = GlobalKey<FormState>();
  final _todoController = TextEditingController();

  final _items = <Todo>[];

  @override
  void dispose() {
    // TODO: implement dispose
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return '할 일을 입력해 주세요.';
                          }
                        }
                        return null;
                      },
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: '할 일 입력',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('할 일 추가');

                    // 키보드 내리기
                    FocusScope.of(context).unfocus();

                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        String title = _todoController.text.trim();
                        if(title.length < 2) {
                          Fluttertoast.showToast(
                            msg: '할 일을 2글자 이상 입력해 주세요.',
                            backgroundColor: Colors.blue,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          Todo todo = Todo(title);
                          // _items.add(todo);
                          // _todoController.text = "";

                          FirebaseFirestore.instance.collection('todo')
                              .add({'title': todo.title, 'isDone': todo.isDone});
                          _todoController.text = "";
                        }
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: '할 일을 다시 입력해주세요.',
                          backgroundColor: Colors.blue,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  },
                  child: Text('추가'),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('todo').snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final document = snapshot.data!.docs;
                return Expanded(
                  child: ListView(
                    //children: _items.map((e) => _buildItemWidget(e)).toList(),
                    children: document.map((e) => _buildItemWidget(e)).toList(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () {
        print('아이템 클릭');

        setState(() {
          //todo.isDone = !todo.isDone;

          FirebaseFirestore.instance.collection('todo').doc(doc.id).update(
              {'isDone': !doc['isDone'],
              });
        });
      },
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              )
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () {
          print('삭제 클릭');

          setState(() {
            //_items.remove(todo);

            FirebaseFirestore.instance.collection('todo').doc(doc.id).delete();
          });
        },
      ),
    );

  }
}

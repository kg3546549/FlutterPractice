import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home : MyApp()
    )
  );
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Accounts {
  String name='';
  String phoneNumber = '';
  int likes=0;
  Accounts(String name, String phoneNumber , int likes) {
    this.name = name;
    this.phoneNumber = phoneNumber;
    this.likes = likes;
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var accounts = [
    Accounts('D' , '01012341234' , 0),
    Accounts('Z' , '01012341234' , 0),
    Accounts('A' , '01012341234' , 0),
    Accounts('C' , '01012341234' , 0),
  ];

  addAccount(var arr, String name, String phoneNumber , int likes) {
    setState(() {
      arr.add( Accounts(name , phoneNumber ,likes) );
    });
    // print(arr[arr.length-1].name);
  }

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: Text('+',style: TextStyle(fontSize: 25),),
              onPressed: (){
                showDialog(context : context, builder : (context) {
                  return AddDialog( account : accounts , addFunc : addAccount );
                });
              },
            );
          }
        ),

        appBar : AppBar(
          title : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('연락처'),
                  Text('친구 수 : ' + accounts.length.toString()),
                  IconButton(
                      icon: Icon(Icons.sort) ,
                      onPressed: (){
                        setState( (){
                          accounts.sort( (a,b) => a.name.compareTo(b.name) );
                        });
                      }),
                ],
              )
          ),
        ),

        body : ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context , i){
            return ListTile(
              leading: Icon(Icons.account_circle),
              title : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(accounts[i].name),
                  Text(accounts[i].phoneNumber),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    accounts[i].likes++;
                  });
                },
                child : Text('좋아요  ' + accounts[i].likes.toString()),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: BottomCallBar(),
        ),
      );
  }
}

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key , this.account , this.addFunc}) : super(key: key);
  final account;
  final addFunc;

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 300,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contact" , style: TextStyle(fontWeight: FontWeight.w700 , fontSize : 20),),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide : BorderSide(width: 1, color : Colors.blueAccent),
                  ),
                  hintText : '이름을 입력하세요.',
                  labelText : '이름',
                ),
                controller: nameController,
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide : BorderSide(width: 1, color : Colors.blueAccent),
                  ),
                  hintText : '전화번호를 입력하세요.',
                  labelText : '전화번호',
                ),
                controller: numberController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: (){
                    if(nameController.text != '' && numberController.text != '') {
                      widget.addFunc(widget.account,nameController.text , numberController.text , 0);
                      nameController.text = numberController.text = '';
                      Navigator.pop(context);
                    }
                    else {
                      showDialog(context: context, builder: (context) {
                        return Dialog(
                          child : Container(
                            width: 200,
                            height : 50,
                            child: Text('이름을 입력하세요' , style: TextStyle(fontSize : 25),),
                          ),
                        );
                      });
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




class BottomCallBar extends StatelessWidget {
  const BottomCallBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.contact_page),
              onPressed: (){},
            ),
          ],
        ),
    );
  }
}
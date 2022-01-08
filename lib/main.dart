

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
  int likes=0;
  Accounts(String name, int likes) {
    this.name = name;
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
  ];

  addAccount(var arr, String name, int likes) {
    setState(() {
      arr.add( Accounts(name,likes) );
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
          title : Text('친구 수 : ' + accounts.length.toString()),
        ),
        body : ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context , i){
            return ListTile(
              leading: Icon(Icons.account_circle),
              title : Text(accounts[i].name),
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
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contact" , style: TextStyle(fontWeight: FontWeight.w700 , fontSize : 20),),
            TextField(
              controller: myController,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    print(context.toString());
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: (){
                    widget.addFunc(widget.account,myController.text,0);
                    myController.text = '';
                    Navigator.pop(context);
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
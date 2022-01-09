import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
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


class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      // print('허락됨');
      var Contacts = await ContactsService.getContacts();
      // print(Contacts.length);
      setState(() {
        accounts = Contacts;
      });


    } else if (status.isDenied) {
      // print('거절됨');
      Permission.contacts.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  var a = 1;
  var accounts = [
  ];

  addAccount(var arr, String name, String phoneNumber , int likes) {
    setState(() {
      List<Item> ItemList = [
        Item( label: 'mobile', value: phoneNumber)
      ];

      var newPerson = Contact(
        givenName: name,
        phones : ItemList,
      );

      ContactsService.addContact(newPerson);
    });
    getPermission();
    // print(arr[arr.length-1].name);
  }

  isPhoneNumber(int i) {

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
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.contacts) ,
                          onPressed: (){
                            getPermission();
                          }),
                      IconButton(
                          icon: Icon(Icons.sort) ,
                          onPressed: (){
                            setState( (){
                              accounts.sort( (a,b) => a.name.compareTo(b.name) );
                            });
                          }),
                    ],
                  ),
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
                  Text(accounts[i].givenName + ' ' + accounts[i].familyName),
                  // Text(accounts[i]),
                ],
              ),
              subtitle: PhoneTextW( account : accounts[i] , i : i),
              // subtitle: Text(accounts[i]?.phones[0]?.value),

                  

              trailing: ElevatedButton(
                onPressed: () {
                  // phoneNumber(i);
                  // setState(() {
                  //   // accounts[i].likes++;
                  // });
                },
                child : Text('좋아요'),
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
                    if(nameController.text != '') {
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

class PhoneTextW extends StatefulWidget {
  const PhoneTextW({Key? key,this.account , this.i}) : super(key: key);
  final account;
  final i;

  @override
  _PhoneTextWState createState() => _PhoneTextWState();
}

class _PhoneTextWState extends State<PhoneTextW> {

  isEmptyInAccountsPhoneNumber(account,i) {
    //전화번호가 없을 떄
    if(account.phones.length == 0) return '';

    for(int aa=0;aa<account.phones.length;aa++) {
      if( account.phones[aa] != null ) {
        return ' (' + account.phones[aa].label + ') ' + account.phones[aa].value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text( isEmptyInAccountsPhoneNumber(widget.account,widget.i) );
  }
}

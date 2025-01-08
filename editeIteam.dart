import 'package:flutter/material.dart';
import 'addCategory.dart';
import 'addItem.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class editItem extends StatefulWidget {
  const editItem({super.key});

  @override
  State<editItem> createState() => _editItemState();
}

class _editItemState extends State<editItem> {
  final TextEditingController id=new TextEditingController();
  final TextEditingController action=new TextEditingController();
  String massage='';
  void setMassage(String s){
    setState(() {
      s=massage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Ations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('addCategory'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=> addCategory()
                    )
                );
              },
            ),
            ListTile(
              title: Text('addItem'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=> addItem()
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child:Padding(
              padding: EdgeInsets.all(20),
              child:  ListView.builder(
                itemCount: 1,
                itemBuilder: (context,index){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Text('Enter Item ID'),
                        SizedBox(height: 8,),
                        TextField(
                          controller: id,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'ID',
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Enter the price or quantity to change'),
                        SizedBox(height: 8,),
                        TextField(
                          controller: action,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter number to be set',
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                              setPrice(id, action,setMassage);
                            }, child: Text('set price')),
                            SizedBox(width: 30,),
                            ElevatedButton(onPressed: (){
                              setQuantity(id, action,setMassage);
                            }, child: Text('set quantity')),
                            SizedBox(width:30,),
                            ElevatedButton(onPressed: (){
                              deleteItem(id,setMassage);
                            }, child: Text('Delete')),
                            SizedBox(width: 4,),


                          ],
                        ),
                        SizedBox(height: 20,),
                        Text(massage,style: TextStyle(fontSize: 20,color: Colors.red),),
                      ],
                    ),
                  );
                },
              )
          )
      ),
    );
  }
}

void setPrice(TextEditingController id,TextEditingController action,Function(String s)setMassage)async{
  try{
    final url=Uri.https(link,'setPrice.php');
    String cid=id.text;
    String price=action.text;
    final response=await http.post(url,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
            <String,String>{
              'iteam_id':cid,
              'price':price
            }
        )).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      id.clear();
      action.clear();
    }else{
      String s='The price dosnt set';
      setMassage(s);
    }
  }catch(e){
    print(e);
  }
}

void setQuantity(TextEditingController id,TextEditingController action,Function(String s)setMassage)async{
  try{
    final url=Uri.https(link,'setQuantity.php');
    String cid=id.text;
    String quantity=action.text;
    final response=await http.post(url,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
            <String,String>{
              'iteam_id':cid,
              'quantity':quantity
            }
        )).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      id.clear();
      action.clear();
    }else{
      String ms='the quantity dosnt change';
      setMassage(ms);
    }
  }catch(e){
    print(e);
  }
}

void deleteItem(TextEditingController id,Function(String s)setMassage)async{
  try{
    final url=Uri.https(link,'delete.php');
    String cid=id.text;
    final response=await http.post(url,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
            <String,String>{
              'iteam_id':cid,
            }
        )).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      id.clear();
    }else{
      String ms='the item dosnt deleted';
      setMassage(ms);
    }
  }catch(e){
    print(e);
  }
}
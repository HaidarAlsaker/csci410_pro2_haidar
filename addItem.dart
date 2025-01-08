import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mobile_project_2/addCategory.dart';
import 'item.dart';
import 'editeIteam.dart';

String url="mobileproject410.000webhostapp.com";

class addItem extends StatefulWidget {
  const addItem({super.key});

  @override
  State<addItem> createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  final TextEditingController id=new TextEditingController();
  final TextEditingController name=new TextEditingController();
  final TextEditingController price=new TextEditingController();
  final TextEditingController quantity=new TextEditingController();
  final TextEditingController category=new TextEditingController();
  final TextEditingController image=new TextEditingController();
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
        title: Text('Add Item'),
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
              title: Text('edit Iteam'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=> editItem()
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
                      children: [
                        SizedBox(height: 10,),
                        Text('Enter Item id'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: id,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter item ID',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Enter Item name'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter item Name',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Enter Item category'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: category,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Category id',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Enter Item price'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: price,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Item price',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Enter Item quantity'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: quantity,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter quantity',
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Enter Item image Url'),
                        SizedBox(height: 5,),
                        TextField(
                          controller: image,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'URL',
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(onPressed: (){
                          AddItem(id,name,quantity,price,category,image,setMassage);
                        }, child: Text('add')),
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

void AddItem(TextEditingController id,TextEditingController name,TextEditingController quantity,TextEditingController price,TextEditingController category,TextEditingController image,Function(String s)setMassage)async{
  try{
    final link=Uri.https(url,'addItem.php');
    final response=await http.post(link,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(
            <String,String>{
              'iteam_id':id.text,
              'iteam_name':name.text,
              'price':price.text,
              'quantity':quantity.text,
              'category':category.text,
              'image':image.text
            }
        )
    ).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      id.clear();
      name.clear();
      price.clear();
      quantity.clear();
      category.clear();
      image.clear();
    }else{
      String ms='Item filed to added';
      setMassage(ms);
    }
  }catch(e){

  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mobile_project_2/addItem.dart';
import 'package:mobile_project_2/editeIteam.dart';

String link="mobileproject410.000webhostapp.com";

class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  final TextEditingController id=new TextEditingController();
  final TextEditingController name=new TextEditingController();
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
        title: Text('Add Category'),
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
              title: Text('addItem'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=> addItem()
                    )
                );
              },
            ),
            ListTile(
              title: Text('Edit Item'),
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Enter the category ID',style: TextStyle(fontSize: 20),),
                SizedBox(height: 10,),
                TextField(
                  controller: id,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Category ID',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20,),
                Text('Enter the Category Name',style: TextStyle(fontSize: 20),),
                SizedBox(height: 10,),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Category Name',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  addCat(id,name,setMassage);
                }, child: Text('ADD')),
                Text(massage,style: TextStyle(fontSize: 20,color: Colors.red),),
              ],
            ),
          )
      ),
    );
  }
}


void addCat(TextEditingController id,TextEditingController name,Function(String ms)setMassege)async{
  String cid=id.text;
  String cname=name.text;
  if(cid.trim()!=null && cname.trim()!=null){
    try{
      final url=Uri.https(link,'addCategory.php');
      final response=await http.post(url,
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(
              <String,String>{
                'category_id':cid,
                'category_name':cname
              }
          )).timeout(Duration(seconds: 5));
      if(response.statusCode==200){
        id.clear();
        name.clear();
      }else{
        String ms='the category dosnt added';
        setMassege(ms);
      }
    }catch(e){
      print(e);
    }
  }else{
    String ms='fill all the fileds';
    setMassege(ms);
  }

}
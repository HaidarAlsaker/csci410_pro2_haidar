import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mobile_project_2/addCategory.dart';
import 'user.dart';
import 'item.dart';
import 'items.dart';
import 'register.dart';

String url="mobileproject410.000webhostapp.com";
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email=new TextEditingController();
  final TextEditingController _password=new TextEditingController();
  String massage='';
  bool _load=false;
  List<User> u=[];
  void setMassage(String s){
    setState(() {
      s=massage;
    });
  }

  @override
  void initState() {
    super.initState();
    cheakLogin(_email,_password,setMassage,u);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Enter your email'),
                SizedBox(height: 20,),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your email',
                  ),
                ),
                SizedBox(height: 20,),
                Text('Enter your password'),
                SizedBox(height: 20,),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your password',
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      cheakLogin(_email,_password,setMassage,u);
                      print(u[0].id);
                      if(u[0].role==1){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context)=> addCategory()
                            )
                        );
                      }else{
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context)=> ShowItems(u: u[0],)
                            )
                        );
                      }
                    }, child: Text('login')
                    ),
                    SizedBox(width: 4,),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=> Register()
                          )
                      );
                    }, child: Text('Register'))
                  ],
                ),
                SizedBox(height: 20,),
                Text(massage),
              ],
            ),
          )
      ),
    );
  }
}


void cheakLogin(TextEditingController email,TextEditingController password,Function(String)setMassage,List<User> u)async{
  try{
    final link=Uri.https(url,'login.php');
    final response=await http.post(link,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:convert.jsonEncode(
            <String,String>{
              "email":'${email.text}',
              "password": '${password.text}',
            })
    ).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      var data=json.decode(response.body);
      for(var row in data){
        User a=User(
            int.parse(row['id']),
            row['email'],
            row['password'],
            int.parse(row['role'])
        );
        u.add(a);
      }
    }
    if(response.statusCode!=200){
      String ms='the email or password is incorrect';
      setMassage(ms);
    }

  }catch(e){
    print(e);
  }
}
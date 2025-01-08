import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'user.dart';
import 'items.dart';

String link="mobileproject410.000webhostapp.com";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<User> user=[];
  final TextEditingController _email=new TextEditingController();
  final TextEditingController _password=new TextEditingController();
  final TextEditingController _repassword=new TextEditingController();
  String mass='';

  void setMassege(String m){
    setState(() {
      mass=m;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Center(
          child:Padding(
            padding: EdgeInsets.all(20),
            child:  Column(
              children: [
                SizedBox(height: 20,),
                Text('Enter your email'),
                SizedBox(height: 8,),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your email',
                  ),
                ),
                SizedBox(height: 20,),
                Text('Enter a password'),
                SizedBox(height: 8,),
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
                Text('Rewrite the password'),
                SizedBox(height: 8,),
                TextField(
                  controller: _repassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your password',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  register(user,setMassege,_email, _password, _repassword);
                  print(user[0].id);
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=> ShowItems(u: user[0],)
                      )
                  );

                }, child: Text('Register')
                ),
                SizedBox(height: 20,),
                Text(mass),
              ],
            ),
          )
      ),
    );
  }
}

void register(List<User> u,Function(String)setMass,TextEditingController email,TextEditingController password,TextEditingController repassword)async{
  try{
    if(password.text==repassword.text){
      final url=Uri.https(link,'register.php');
      final response=await http.post(url,
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(
              <String,String>{
                'email':email.text,
                'password':password.text
              }
          )).timeout(Duration(seconds: 5));
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
      }else{
        String ms='the email is not accepted';
        setMass(ms);
      }
    }else{
      String ms='the 2 fileds of password should be the same';
      setMass(ms);
    }
  }catch(e){
    print(e);
  }
}
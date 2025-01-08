import 'package:flutter/material.dart';
import 'item.dart';
import 'items.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'user.dart'
;
String link="mobileproject410.000webhostapp.com";


class myCart extends StatefulWidget {
  List<Item> cart;
  User? user;
  myCart({super.key,required this.cart,required this.user});

  @override
  State<myCart> createState() => _myCartState();
}

class _myCartState extends State<myCart> {
  void update(bool success) {
    if (success) { // open the Add Category page if successful
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) =>  myCart(cart: cart,user: widget.user,)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to set key')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCart'),
        centerTitle: true,
        actions: [
          Tooltip(
            message: 'Buy',
            child: IconButton(
              icon:Icon(Icons.account_balance_wallet),
              onPressed: (){
                for(Item x in widget.cart){
                  addToCart(x,widget.user!);
                }
              },
            ),
          )
        ],

      ),
      body: Center(
        child: showCart(cart: widget.cart),
      ),
    );
  }
}



class showCart extends StatefulWidget {
  List<Item>cart;
  showCart({super.key,required this.cart});

  @override
  State<showCart> createState() => _showCartState();
}

class _showCartState extends State<showCart> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:widget.cart.length ,
        itemBuilder: (context,index){
          String x=widget.cart[index].quantity.toString();

          if(widget.cart.length>0){
            return Column(
              children: [
                SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: Image.network(widget.cart[index].url,width: 200,height: 200),
                ),
                SizedBox(width: 2,),
                SizedBox(height: 5,),
                Column(
                  children: [

                    Text(widget.cart[index].name),
                    SizedBox(height: 1,),
                    Text((widget.cart[index].price).toString() ),
                  ],
                ),
                SizedBox(height:5 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(widget.cart[index].quantity>0){
                        setState(() {
                          widget.cart[index].quantity--;
                        });
                      }
                    }, child: Text('-')),
                    SizedBox(width: 6,),
                    Text(x),
                    SizedBox(width: 6,),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        widget.cart[index].quantity++;
                      });
                    }, child: Text('+')),
                  ],
                ),
              ],
            );
          }else{
            return Column(
              children: [
                Text('YOUR CART IS EMPTY')
              ],
            );
          }
        }
    );
  }
}

void addToCart(Item c,User u) async{
  try{
    final url=Uri.https(link,'addToCart.php');
    final response=await http.post(url,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String,int>{
          'user_id':u.id,'iteam_id':c.id,'quantity':c.quantity,'subtotal':(c.price*c.quantity).toInt()
        })).timeout(Duration(seconds: 5));
  }catch(e){
    print(e);
  }

}
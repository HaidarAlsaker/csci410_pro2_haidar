import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'item.dart';
import'cart.dart';
import 'user.dart';

String link="mobileproject410.000webhostapp.com";
List<Item> cart=[];

class ShowItems extends StatefulWidget {
  User? u;
  ShowItems({super.key,required this.u});

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  bool _load=false;
  List<Item>items=[];
  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }
  @override
  void initState() {
    getItems(items,update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? i=widget.u;
    return Scaffold(
        appBar: AppBar(
          title: Text('items'),
          centerTitle: true,
          actions: [
            Tooltip(
              message: 'cart',
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          settings: RouteSettings(arguments: cart),
                          builder: (context)=> myCart(cart: cart,user: i)
                      )
                  );
                },
                icon: Icon(
                    Icons.shopping_cart
                ),
              ),
            ),
          ],
        ),

        body: _load? listIteams(items: items,):const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}


class listIteams extends StatelessWidget {
  List<Item> items;
  listIteams({super.key,required this.items});


  @override
  Widget build(BuildContext context) {

    print(items);
    return ListView.builder(

        padding: const EdgeInsets.all(20.0),
        itemCount: items.length,
        itemBuilder: (context, index){
          return Column(children: [
            const SizedBox(height: 10),
            Text(items[index].toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Image.network(items[index].url),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              bool found=false;
              Item a=Item(items[index].id, items[index].name, items[index].price, 1, items[index].category, items[index].url);
              for(var x in cart){
                if(x.id==a.id){
                  found=true;
                  break;
                }
              }
              if(found==false){
                cart.add(a);
              }
            }, child: Text('Add'))
          ]);
        });
  }
}

void getItems(List<Item>items,Function(bool success)update) async {
  try{
    final url=Uri.https(link,'getItems.php');
    final response=await http.get(url).timeout(Duration(seconds: 5));
    if(response.statusCode==200){
      final jsonResponse = convert.jsonDecode(response.body);
      for(var row in jsonResponse){
        Item i=Item(
            int.parse(row['iteam_id']),
            row['iteam_name'],
            double.parse(row['price']),
            int.parse(row['quantity']),
            int.parse(row['category']),
            row['image']
        );
        items.add(i);
      }
      update(true);
    }
  }catch(e){
    print(e);
  }
}
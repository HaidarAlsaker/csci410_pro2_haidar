
class Item {
  int _id;
  String _name;
  double _price;
  int _quantity;
  int _category;
  String _url;

  Item(this._id,this._name, this._price, this._quantity,this._category, this._url);

  int get id=>_id;
  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
  String get url => _url;
  int get category=>_category;

  set id(int id) => id=_id;
  set name(String name) =>_name = name;
  set price(double price) =>_price = price;
  set quantity(int quantity) =>_quantity = quantity;
  set url(String url) =>_url = url;
  set category(int category)=>_category = category;

  @override
  String toString() {
    return 'Price: \$$_price Name:$_name';
  }
}
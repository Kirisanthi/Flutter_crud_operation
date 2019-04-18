import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  String name,code,description,price,quantity;
  DocumentReference reference;


  User ({this.name,this.code,this.description,this.price,this.quantity
  });
  User.fromMap(Map<String, dynamic> map, {this.reference}){
    name =map["name"];
    code =map["code"];
    description=map["description"];
    price =map["price"];
    quantity=map["quantity"];
  }
  User.fromSnapShort(DocumentSnapshot snapshot)
        :this.fromMap(snapshot.data, reference: snapshot.reference);
  

  toJson(){
    return{
      'name': name,
      'code':code,
      'description':description,
      'price':price,
      'quantity':quantity
    };
  }
}
  
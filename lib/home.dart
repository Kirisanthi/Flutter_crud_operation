

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'search.dart';


class Home extends StatefulWidget {

@override
_MyHomePageState createState() => _MyHomePageState(); }
class _MyHomePageState extends State<Home> {
   
bool showTextField =false;
TextEditingController controller =TextEditingController();
TextEditingController controller1 =TextEditingController();
TextEditingController controller2 =TextEditingController();
TextEditingController controller3 =TextEditingController();
TextEditingController controller4 =TextEditingController();


String collectionName ="Users";
bool isEditing = false;
User curUser;

getUsers(){
return Firestore.instance.collection(collectionName).snapshots();

}
addUser(){
  User user = User(name: controller.text, code: controller1.text, description:controller2.text, price:controller3.text, quantity:controller4.text);
try{
  Firestore.instance.runTransaction(
    (Transaction transaction) async{
      await Firestore.instance
      .collection(collectionName)
      .document().setData(user.toJson());
    }
  );

}catch(e){
  print(e.toString());
}
}

add(){
if(isEditing){
update(curUser, controller.text,controller1.text,controller2.text,controller3.text,controller4.text);
setState(() {
  isEditing = false;
});
}
else{
  addUser();
}

controller.text = '';
controller1.text = '';
controller2.text = '';
controller3.text = '';
controller4.text = '';
}

update(User user, String newName,String newCode, String newDescription, String newPrice, String newQuantity){
    
Firestore.instance.runTransaction(
(Transaction transaction) async{
await transaction.update(user.reference, 
{
 'name': newName,
 'code': newCode,
 'description': newDescription,
 'price': newPrice,
 'quantity': newQuantity

  },);
    },
  );


}

delete(User user){
Firestore.instance.runTransaction(
(Transaction transaction) async{
await transaction.delete(user.reference);
},
);
}

Widget buildBody(BuildContext context){
return StreamBuilder<QuerySnapshot>(
stream: getUsers(),
builder: (context,snapshot){
  if (snapshot.hasError){
        return Text('Error ${snapshot.error}');
      }
  if(snapshot.hasData){
        print("Documents ${snapshot.data.documents.length}");
        return buildList(context,snapshot.data.documents);
        }

return CircularProgressIndicator();
  },);}

Widget buildList(BuildContext context, List<DocumentSnapshot>snapshot){
  return ListView(
    children:snapshot.map((data) => buildListItem(context, data)).toList(),
  );
}

Widget buildListItem(BuildContext context,DocumentSnapshot data){
final user= User.fromSnapShort(data);
return Padding(
key: ValueKey(
user.name, ),

padding:  EdgeInsets.symmetric(vertical: 8.0),
child: Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(5.0),
  ),

  child: ListTile(
    title:  Text(user.name),
      trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: (){
delete(user);
      },
    ),
    onTap: (){
      setUpdateUI(user);
          },
      
        ),
      ),
      );
      }
setUpdateUI(User user){
  controller.text = user.name;
  controller1.text = user.code;
  controller2.text = user.description;
  controller3.text = user.price;
  controller4.text = user.quantity;

setState(() {
    showTextField = true;
    isEditing = true;
    curUser =user;
  });
  
}

      
      
button(){
  return SizedBox(
  width: double.infinity,
  child: OutlineButton(
  child: Text (isEditing ?"UPDATE":"ADD"),
  onPressed: (){
  add();
  setState(() {
  showTextField = false;
  });
  },));}
      
      
@override
  Widget build(BuildContext context) { return MaterialApp(
  home: Scaffold(
  appBar: AppBar(
  title: Text("Navigation sample"),
  actions: <Widget>[
  IconButton(
  icon: Icon(Icons.add),
  onPressed: (){
  setState(() {
  showTextField = !showTextField;
  });},)], ),
      
      
body: new Container(
  padding: EdgeInsets.all(20.0),
  child:  Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
  showTextField? Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
  TextFormField(
  controller: controller,
  decoration: InputDecoration(
  labelText: "Name",
  hintText: "Enter name"
  ),
  ),
      
SizedBox(
  height:  5,
),


TextFormField(
        controller: controller1,
        decoration: InputDecoration(
          labelText: "Code",
          hintText: "Enter code"
        ),
      ),


       SizedBox(
        height:  5,
      ),


      TextFormField(
        controller: controller2,
        decoration: InputDecoration(
          labelText: "Description",
          hintText: "Enter description"
        ),
      ),

      SizedBox(
        height:  5,
      ),


      TextFormField(
        controller: controller3,
        decoration: InputDecoration(
          labelText: "Price",
          hintText: "Enter price"
        ),
      ),

      SizedBox(
        height:  5,
      ),


      TextFormField(
        controller: controller4,
        decoration: InputDecoration(
          labelText: "Quantity",
          hintText: "Enter quantity"
        ),
      ),
      
      
      button(),
      
      
      ],
        )
        : Container(),

RaisedButton(
  
  child: Text('Search'),
  onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyApp1()));
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              }
),








        SizedBox(height: 20,),
        Text("USERS",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900
        ),),
        SizedBox(height: 20,),
        Flexible(child: buildBody(context),)
        ],),
      ),
      )
      ); 
      }
      
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MyList(),
      debugShowCheckedModeBanner: false,
    );
  }
}//end of StatelessWidget

class MyList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new _MyJsonList();
  }

}

class _MyJsonList extends State<MyList>{


  Future<List<userList>> _getUserList() async{

    String url = "https://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2";

    var data= await http.get(url);//collect data from url

    var jsonDataObject = json.decode(data.body);//convert the data into object from json

    List<userList> User =[];

    for(var i in jsonDataObject){
      userList userlist = userList(i["index"],i["name"], i["about"],i["email"], i["picture"] );
      User.add(userlist); //adding data in list
    }//end of for loop
    return User;
  }//future getUserList Function


  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text('Json List'),

      ),
      body: Container(
        height: 200.0,
        child: FutureBuilder(
          future: _getUserList(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return ListView.builder(
              scrollDirection:Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data == null) {

                  return Container(
                    child: Center(
                  child: Text('Data Reloaded'),
                  ),

                  );
    }else{          return Container(
                              width: 160.0,


                            child: Card(


                              child: Wrap(
                                children: <Widget>[
                                  Image.network(snapshot.data[index].picture),
                                  Text(snapshot.data[index].name),
                                  Text(snapshot.data[index].email)
                                ],
                              ),
      ),
    );
                }
              }
              );
    
          

          },//end of builder
        ),
      ),

    );
  }//end of code of WidgetBuild

}//end of code of State

class userDetails extends StatelessWidget{

  userList user;
  userDetails(this.user);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Text(user.email),
      ),
    );
  }
  
}

class userList{

  final int index;
  final String  name, about, email, picture;
  userList( this.index, this.name, this.about, this.email, this.picture);
}
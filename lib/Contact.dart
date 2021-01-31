import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Contact extends StatefulWidget{

@override
ContactState createState() => ContactState();
}


class ContactState extends State<Contact>
{
  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final titoController = TextEditingController();
  final bodiController = TextEditingController();
 
  // Boolean variable for CircularProgressIndicator.
  bool visible = false ;
 
  Future webCall() async{
 
    // Showing CircularProgressIndicator using State.
    setState(() {
     visible = true ; 
    });
 
    // Getting value from Controller
    String name = nameController.text;
    String email = emailController.text;
    String tito = titoController.text;
    String bodi = bodiController.text;
 
    // API URL
    var url = 'https://pacwil.000webhostapp.com/submit_data.php';
 
    // Store all data with Param Name.
    var data = {'name': name, 'email': email, 'tito' : tito, 'bodi' : bodi};
 
    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));
 
    // Getting Server response into variable.
    var message = jsonDecode(response.body);
 
    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
       visible = false; 
      });
    }
 
    // Showing Alert Dialog with Response JSON.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
 
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
    actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      onPressed: () {
        print("this settings");
      },
    )
  ],
        title: Text('contact page'),
      ),
     body: SingleChildScrollView(
     child: Container(
       child: Center(
         child: Column(
           children: <Widget>[
             Container(
             margin: const EdgeInsets.only(top: 20.0),
             child: Text("Send us your message", style: TextStyle(fontSize:20, color:Colors.blue,fontWeight: FontWeight.bold,),),
             ),

             Divider(),

             Container(
               width:250,
               padding: const EdgeInsets.all(10),
               child: TextField(
                 controller: nameController,
                 autocorrect: true,
                 decoration: InputDecoration(hintText:'Enter your name'),
               ),
             ),

             Container(
               width: 250,
               padding: const EdgeInsets.all(10),
               child: TextField(
                 controller: emailController,
                 autocorrect: true,
                 decoration: InputDecoration(hintText: 'Enter your email'),
               ),
             ),

             Container(
               margin: const EdgeInsets.only(top:10.0),
               padding: const EdgeInsets.all(10),
               width: 250,
               child: TextField(
                 controller: titoController,
                 autocorrect: true,
                 decoration: InputDecoration(hintText:'Enter message title', border: OutlineInputBorder()),
               ),
             ),

             Container(
               padding: const EdgeInsets.all(10),
               width: 250,
               child: TextField(
                 keyboardType: TextInputType.multiline,
                 maxLines: 5,
                 controller: bodiController,
                 autocorrect: true,
                 decoration: InputDecoration(hintText: 'Enter your message', border: OutlineInputBorder()),
               ),
             ),

    Visibility(
                visible: visible, 
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator()
                  )
                ),

      RaisedButton(
         onPressed: webCall,
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text('Send'),
        ),
        


        RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text('Return to Home'),
        ),
             

           ],
         ),
       ),
     ),
    ),
    );
  }
}
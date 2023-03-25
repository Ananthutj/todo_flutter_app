// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tokoto/Providers/authentication_provider.dart';
import 'package:tokoto/Utils/message.dart';
import 'package:tokoto/screens/main_activity.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 152, 207, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 160, 45, 198),
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 70,),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/welcome1.jpg'),
                    ),
                    SizedBox(height: 20,),
                  Text("Welcome To",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
                  Text("Poll App",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
                  SizedBox(height: 100,),
                    
                ElevatedButton(
                  
                style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(60)
            ), backgroundColor: Color.fromARGB(255, 244, 237, 237),
            elevation: 5
                ),
                onPressed: () {
                  AuthProvider().signInWithGoogle().then((value) {
                      if(value.user==null){
                        error(context, message: "Try Again");
                      }
                      else
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>MainActivity()));
                      }
                  });
                },
                
                child: Padding(
                  
                  padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                  child: Row(
                    
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/g1.png"),
                        height: 24.0,
                        width: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 8),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
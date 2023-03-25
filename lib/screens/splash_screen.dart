// ignore_for_file: prefer_const_constructors, implementation_imports, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tokoto/screens/Authentication/auth_page.dart';
import 'package:tokoto/screens/main_activity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user = FirebaseAuth.instance.currentUser;

  void navigate(){
    
    Timer(Duration(seconds: 5), () {
      if(user==null){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>AuthPage()));
    }
    else
    {
      Navigator.push(context, MaterialPageRoute(builder: (_)=>MainActivity()));
    }
     });
  }

  
  @override
  void initState() {
    
    super.initState();
    navigate();
     
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 212, 212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            
            children:  [
              
              SizedBox(height: 200,),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/todo.png'),
              ),
              
              SizedBox(height: 20,),
              Text("Please wait.....",style: TextStyle(fontSize:17),),
              SizedBox(height: 20,),
              LinearProgressIndicator(
                backgroundColor: Colors.orange,
                color: Color.fromARGB(255, 69, 7, 136)
              ),
                
              ],
          ),
        ),
      
      )
      
    );
  }
}
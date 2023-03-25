// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/Providers/authentication_provider.dart';
import 'package:tokoto/screens/editpage.dart';
import 'package:tokoto/models/user_models.dart';
import 'package:tokoto/remote_data_source/firestore_helper.dart';
import 'package:tokoto/screens/Addtask.dart';


class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  String uid='';

  getuid() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user=await auth.currentUser;
    setState(() {
      uid=user!.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getuid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Color.fromARGB(255, 101, 76, 29),
        actions: [
          IconButton(
            
            onPressed: (){
              showDialog(context: context, builder: (_){
                return AlertDialog(
                  title: Text("LOGOUT"),
                  content: Text("Are you sure?"),
                  actions: [
                    ElevatedButton(
                      onPressed: (){
                        AuthProvider().signOut();
                        Navigator.pop(context);
                      }, 
                      child: Text("Logout")
                    ),
                  ],
                );
              }
             );
            },
            icon: Icon(Icons.logout))
        ],
        title: Text("TODO"),
      ),
      backgroundColor: Color.fromARGB(137, 34, 33, 83),
      body:Container(
        child: Column(  
         children: [
          StreamBuilder<List<UserModel>>(
            stream: firestoreHelper.read(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasData){
                final userData=snapshot.data;
                return Expanded(
                
                 child: ListView.builder(
                  
                  itemBuilder: (context, index) {
                    final singleUser=userData![index];
                    return Container(
                      padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    
                  borderRadius:BorderRadius.circular(20) ,
                  ),
              child: ListTile(
                onLongPress: (){
                  showDialog(context: context, builder: (_){
                    return AlertDialog(
                      title: Text("Delete"),
                      content: Text("Do you want to delete?"),
                      actions: [
                        ElevatedButton(
                          onPressed: (){
                            firestoreHelper.delete(singleUser).then((value) => {
                              Navigator.pop(context)
                          });
                        },
                         child: Text("Delete"),
                         )
                      ],
                    );
                  });
                },
                title: Text("${singleUser.title}",style: TextStyle(color: Colors.white,fontSize: 27),),
                subtitle: Text("${singleUser.description}",style: TextStyle(color: Colors.white),),
                trailing: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>EditPage(user: UserModel(title:singleUser.title,description: singleUser.description,id: singleUser.id),)));
                },
                 icon: Icon(Icons.edit,color: Colors.white,)
                 ),
               ),
              );
            },
                  itemCount: userData!.length,
                ),
                );
                
              }
              return Center(child: CircularProgressIndicator(),);
            }
          )
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTask()));
        },
        child: Icon(Icons.add),
        ),
        
    );
    
  }

  
}
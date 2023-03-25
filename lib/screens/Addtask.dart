// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tokoto/models/user_models.dart';
import 'package:tokoto/remote_data_source/firestore_helper.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Color.fromARGB(255, 16, 58, 92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter title',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter description',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                //addtaskToFirebase();
                firestoreHelper.create(UserModel(title: titleController.text,description: descriptionController.text)).then((value) => {
                  Navigator.pop(context)
                });
              }, 
              style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states){
                if(states.contains(MaterialState.pressed))
                  return Colors.green;
                return Colors.pink;
              })),
              child: Text("Add Task")
            )
          ],
        ),
      ),
    ); 
    
  }
}
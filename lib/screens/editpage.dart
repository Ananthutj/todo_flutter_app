// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tokoto/models/user_models.dart';
import 'package:tokoto/remote_data_source/firestore_helper.dart';

class EditPage extends StatefulWidget {
  final UserModel user;
  const EditPage({Key? key,required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  
   TextEditingController? titleController;
   TextEditingController? descriptionController;

  @override
  void initState() {
 
    titleController=TextEditingController(text: widget.user.title);
    descriptionController=TextEditingController(text: widget.user.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Tasks"),
      ),
      body: Padding(

        padding: EdgeInsets.all(10),
        child: Column(
          children: [
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
                firestoreHelper.update(UserModel(id: widget.user.id,title: titleController!.text,description: descriptionController!.text)).then((value) => {
                  Navigator.pop(context)
                });
              }, 
              style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states){
                if(states.contains(MaterialState.pressed))
                  return Colors.green;
                return Colors.pink;
              })),
              child: Text("Update")
            )
          ],
        ),
        ),
    );
  }
}
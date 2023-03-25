import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier{
  String _message='';
  bool _status=false;

  String get message => _message;
  bool get status => _status;

  User? user=FirebaseAuth.instance.currentUser;

  CollectionReference pollCollection = FirebaseFirestore.instance.collection("polls");

  void addPoll({
    required String question,
    required String duration,
    required List<Map> options
  }) async{
    _status =  true;
    notifyListeners();
    try{

      final data={
        "author":{
          "uid":user!.uid,
          "profileImage":user!.photoURL,
          "name":user!.displayName,
        },
        "DateCreated":DateTime.now(),
        "poll":{
          "totalVotes":0,
          "voters":<Map>[],
          "question":question,
          "duration":duration,
          "options":options,
        },

      };
      await pollCollection.add(data);
      _message="Poll created";
      _status=false;
      notifyListeners();
    } on FirebaseAuthException catch(e){
      _message=e.message!;
      _status=false;
      notifyListeners();
    }catch(e){
      _message="Please try again";
      _status=false;
      notifyListeners();

    }
  }

  void clear() {}
}
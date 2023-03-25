import 'package:flutter/material.dart';

import '../Style/colors.dart';


void success(BuildContext context,{required String message}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: AppColors.blue));
}

void error(BuildContext context,{required String message}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:Text(message),
    backgroundColor: AppColors.red, 
  ));
}
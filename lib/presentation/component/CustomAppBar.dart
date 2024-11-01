import 'package:flutter/material.dart';

class CustomAppBar{
  static CustomAppBar _instance = CustomAppBar._();

  factory CustomAppBar(){
    return _instance;
  }

  CustomAppBar._();

  getAppBar({required Function()? leadAction, required caption}){
    return AppBar(
      leading: IconButton(
        onPressed: leadAction,
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
      title: Text(caption),
    );
  }
}
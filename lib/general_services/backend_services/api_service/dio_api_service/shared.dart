import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static late SharedPreferences sharedPreferences ;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setBool(key , bool? value){
    if(value != null){
      sharedPreferences.setBool(key, value);
    }
  }

  static setCustomer({required customer}){
    sharedPreferences.setString("F", customer);
  }
  static deleteCustomer(){
    sharedPreferences.remove("F");
  }
  static getCustomer(){
    return sharedPreferences.getString("F");
  }
  static Future<bool> deleteData({@required key})async{
    return await sharedPreferences!.remove(key);
  }
  static getBool(key){
    return sharedPreferences.getBool(key) ?? false;
  }
  static getBoolNULL(key){
    return sharedPreferences.getBool(key);
  }
  static Future<bool> setString ({@required key, @required value})async{
    return await sharedPreferences.setString(key, value);
  }
  static getString (key){
    return sharedPreferences.getString(key) ?? "";
  }
  static getStringNull (key){
    return sharedPreferences.getString(key) == "-" ? null : sharedPreferences.getString(key) ;
  }

  static setInt (key ,int? value){
    sharedPreferences.setInt(key, value ?? -1);
  }
  static getInt (key){
    return sharedPreferences.getInt(key) ?? -1;
  }
  static getIntNull1 (key){
    return sharedPreferences.getInt(key) ;
  }

  static getIntNull (key){
    return sharedPreferences.getInt(key) == -1 ? null : sharedPreferences.getInt(key);
  }
  static setDouble (key ,double value){
    sharedPreferences.setDouble(key, value);
  }
  static getDouble (key){
    return sharedPreferences.getDouble(key) ?? 0;
  }

  static clear() async{
    await sharedPreferences.clear();
    return true;
  }
}





import 'package:flutter/material.dart';
import 'package:lesson3_1/counter_storage.dart';
import 'package:lesson3_1/home_page.dart';
import 'package:lesson3_1/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _load = prefs.getString('name') ?? '';
  runApp(MaterialApp(
    home: _load == ''
        ? const LoginPage()
        : MyHomePage(storage: CounterStorage()),
  ));
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lesson3_1/counter_storage.dart';
import 'package:lesson3_1/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.storage,
  }) : super(key: key);

  final CounterStorage storage;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count1 = 0;
  int _count2 = 0;
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadName();
    _loadCount();
    widget.storage.readData().then(
      (int value) {
        setState(() {
          _count2 = value;
        });
      },
    );
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => const LoginPage()));
  }

  void _loadName() async {
    final _prefs = await SharedPreferences.getInstance();
     _name = _prefs.getString('name') ?? '';
  }

  void _loadCount() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      _count1 = _prefs.getInt('Count1') ?? 0;
    });
  }

  void _incCount1() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      _count1 = (_prefs.getInt('Count1') ?? 0) + 1;
      _prefs.setInt('Count1', _count1);
    });
  }

  Future<File> _incCount2() {
    setState(() {
      _count2++;
    });
    return widget.storage.writeData(_count2);
  }

  void _removeCount1() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      _count1 = 0;
      _prefs.remove('Count1');
    });
  }

  Future<File> _removeCount2() {
    setState(() {
      _count2 = 0;
    });
    return widget.storage.writeData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
            ),
          ],
          title: const Text('Lesson 3.1'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30, 10, 80),
                  child: Text(
                      'Опять ты.. $_name!', style: const TextStyle(
                    fontSize: 40,
                  ),),
                ),
                Text(
                  'Counter 1: $_count1',
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: _incCount1,
                    child: const Text('Counter 1 ++ ')),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Counter 2: $_count2',
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: _incCount2,
                    child: const Text('Counter 2 ++ ')),
                const SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                    onPressed: _removeCount1,
                    child: const Text('Обнулить счетчик 1')),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: _removeCount2,
                    child: const Text('Обнулить счетчик 2')),
              ],
            ),
          ),
        ));
  }
}

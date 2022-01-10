import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson3_1/counter_storage.dart';
import 'package:lesson3_1/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your name is:',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.pink,
            ),
            controller: _controller,
            cursorColor: Colors.pink,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.name,
            maxLength: 15,
            textInputAction: TextInputAction.go,
            enableSuggestions: false,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('name', _controller.text);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) =>
                            MyHomePage(storage: CounterStorage())));
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  )))),
        ],
      ),
    );
  }
}

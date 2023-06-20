import 'package:flutter/material.dart';
import 'package:phone_auth/OtpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
      ),
      //body: const Placeholder(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: Text(
                    'Phone Authentificator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:40, left: 10, bottom: 40, right: 10,),
                child:  TextField(
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    prefix: Padding(
                      padding: EdgeInsets.all(5),
                      child:  Text('+237',style: TextStyle(color: Colors.black),), 
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: _controller,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: FloatingActionButton(
              focusColor: Colors.blue,
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(phone: _controller.text.trim()), 
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
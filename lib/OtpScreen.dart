import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/homeScreen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  State<OtpScreen> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String _verificationCode = '';
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _globalKey,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                'Verify +237 ${widget.phone}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Pinput(
              controller: _pinController,
              length: 6,
              toolbarEnabled: false,
              onCompleted: (value) async {
                try {
                  await FirebaseAuth.instance
                  .signInWithCredential(
                    PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: value),
                  ) 
                  .then((value) async {
                    if (value.user != null) {
                      print('pass to home');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreem()), 
                        (route) => false
                      );
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _globalKey.currentState?.showBottomSheet((context) => const SnackBar(content: Text('INVALID OTP')));
                }
              },
              onSubmitted: (value) {

              },
            ),
          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+237 ${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
          if (value.user != null) {
            print('user logged in');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreem()), 
              (route) => false
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 120),
    );
  }




}
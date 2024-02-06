import 'dart:async';

import 'package:auth_task/features/circles/circle_widget.dart';
import 'package:auth_task/screens/login_screen.dart';
import 'package:auth_task/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  const OTPScreen(
      {super.key, required this.verificationId, required this.phone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int start = 10;
  bool wait = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        setState(() {
          wait = true;
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    start = 0;
    super.dispose();
  }

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StepCircle(
                  number: 1,
                  active: true,
                  done: true,
                ),
                Container(
                  height: 1,
                  width: 50,
                  color: const Color.fromARGB(255, 190, 186, 186),
                ),
                StepCircle(number: 2, active: true, done: false),
                Container(
                  height: 1,
                  width: 50,
                  color: const Color.fromARGB(255, 190, 186, 186),
                ),
                StepCircle(
                  number: 3,
                  active: false,
                  done: false,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Подтверждение',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              child: Text(
                'Введите код, который мы отправили в SMS на ${widget.phone} ',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              width: 320,
              child: PinCodeTextField(
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                onChanged: (value) async {
                  if (value.length == 6) {
                    {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: otpController.text.toString());
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          String phoneNumber = value.user?.phoneNumber ?? '';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        }).catchError((onError) {
                          print(onError);
                        });
                      } catch (ex) {
                        print(ex.toString());
                      }
                    }
                  }
                },
                controller: otpController,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 60,
                  fieldWidth: 45,
                  activeColor: Colors.black87,
                  selectedColor: Colors.black87,
                  inactiveColor: Colors.black87,
                  disabledColor: Colors.black87,
                  activeFillColor: Colors.black87,
                  selectedFillColor: Colors.black87,
                  inactiveFillColor: Colors.black87,
                  errorBorderColor: Colors.black87,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            wait
                ? RichText(
                    text: TextSpan(children: [
                    TextSpan(
                      text: 'Отправить код еще раз',
                      style: TextStyle(fontSize: 18, color: Colors.orange[500]),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneAuth()));
                        },
                    ),
                  ]))
                : RichText(
                    text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        text: '$start'),
                    const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        text: ' сек до повторной отправки кода')
                  ]))
          ],
        ),
      ),
    ));
  }
}

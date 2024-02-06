import 'package:auth_task/features/circles/circle_widget.dart';
import 'package:auth_task/screens/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  bool isInputComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Закрыть клавиатуру
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                    done: false,
                  ),
                  Container(
                    height: 1,
                    width: 50,
                    color: const Color.fromARGB(255, 190, 186, 186),
                  ),
                  StepCircle(number: 2, active: false, done: false),
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
              const Text('Регистрация',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 30,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: 205,
                child: const Text(
                  'Введите номер телефона для регистрации',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Номер телефона',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange[300]!),
                        ),
                        prefixText: '+7 ',
                      ),
                      onChanged: (value) {
                        if (value.length == 10) {
                          setState(() {
                            isInputComplete = true;
                          });
                        } else {
                          setState(() {
                            isInputComplete = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: isInputComplete
                    ? () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException ex) {
                            // ignore: avoid_print
                            print(ex);
                            setState(() {});
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                  verificationId: verificationId,
                                  phone: '+7${phoneController.text}',
                                ),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                          phoneNumber: '+7${phoneController.text}',
                        );
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      isInputComplete ? Colors.orange[400]! : Colors.grey),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(70, 15, 70, 15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                child: const Text(
                  'Отправить смс-код',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: 232,
                child: RichText(
                  text: TextSpan(
                    text:
                        'Нажимая на данную кнопку, вы даете согласие на обработку ',
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'персональных данных',
                        style:
                            TextStyle(fontSize: 10, color: Colors.orange[400]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // ignore: avoid_print
                            print("cd to any website");
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:auth_task/features/circles/circle_widget.dart';
import 'package:auth_task/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController nameInputControl = TextEditingController();
  final TextEditingController surnameInputControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StepCircle(
                    number: 1,
                    active: false,
                    done: true,
                  ),
                  Container(
                    height: 1,
                    width: 50,
                    color: const Color.fromARGB(255, 190, 186, 186),
                  ),
                  StepCircle(number: 2, active: false, done: true),
                  Container(
                    height: 1,
                    width: 50,
                    color: const Color.fromARGB(255, 190, 186, 186),
                  ),
                  StepCircle(
                    number: 3,
                    active: true,
                    done: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Регистрация',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
              const SizedBox(),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Имя',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameInputControl,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(15),
                      ],
                      keyboardType: TextInputType.name,
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
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Фамилия',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: surnameInputControl,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(20),
                      ],
                      keyboardType: TextInputType.name,
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
                      ),
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange[300]!),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(80, 20, 80, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                name: nameInputControl.text,
                                surname: surnameInputControl.text,
                              )));
                },
                child: const Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              )
            ])),
      ),
    ));
  }
}

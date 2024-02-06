import 'package:auth_task/screens/home_screens/body_sreen/body_screen_account/textfield_name.dart';
import 'package:auth_task/screens/home_screens/body_sreen/body_screen_account/textfield_surname.dart';
import 'package:flutter/material.dart';

class AccountTextInput extends StatefulWidget {
  AccountTextInput(
      {super.key,
      required this.inputHintText,
      this.name,
      this.surname,
      this.stateHandler});
  String? inputHintText;
  String? name;
  String? surname;
  final stateHandler;

  @override
  State<AccountTextInput> createState() => _AccountTextInputState();
}

class _AccountTextInputState extends State<AccountTextInput> {
  final Map<String, String> states = {'Имя': 'name', 'Фамилия': 'surname'};
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.inputHintText,
        hintStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              states[widget.inputHintText] == 'name'
                  ? widget.name ?? ''
                  : widget.surname ?? '',
              style: const TextStyle(color: Colors.black38, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black38,
              ),
              onPressed: () {
                widget.stateHandler(states[widget.inputHintText]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            states[widget.inputHintText] == 'name'
                                ? UserdataTextFieldName(
                                    inputHintText: 'Ваше Имя',
                                    inputType: 'name',
                                    surname: widget.surname)
                                : UserdataTextFieldSurname(
                                    inputHintText: 'Ваша Фамилия',
                                    inputType: 'surname',
                                    name: widget.name,
                                  )));
              },
            ),
          ],
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

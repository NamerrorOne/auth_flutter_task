import 'package:auth_task/screens/home.dart';
import 'package:flutter/material.dart';

class UserdataTextFieldSurname extends StatefulWidget {
  const UserdataTextFieldSurname(
      {super.key,
      required this.inputHintText,
      required this.inputType,
      this.name});
  final String inputHintText;
  final String inputType;
  final String? name;

  @override
  State<UserdataTextFieldSurname> createState() => _UserdataTextFieldSurname();
}

class _UserdataTextFieldSurname extends State<UserdataTextFieldSurname> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Colors.black26,
            height: 1,
            thickness: 1,
          ),
        ),
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: const Row(children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.blue,
                ),
                Text('аккаунт',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ))
              ]),
            ),
            Positioned(
                top: -5,
                right: MediaQuery.of(context).size.width / 4,
                child:
                    const Text('Ваша Фамилия', style: TextStyle(fontSize: 22)))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: TextField(
          onSubmitted: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          name: widget.name,
                          surname: value,
                        )));
          },
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.inputHintText,
            hintStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 20,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

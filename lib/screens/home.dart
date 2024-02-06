import 'package:auth_task/screens/home_screens/bottom_navigation/bottom_bar.dart';
import 'package:auth_task/screens/home_screens/get_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({this.name, this.surname, super.key});

  String? name;
  String? surname;
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String screenStateName = 'user';

  handleScreenState(nameOfActiveIcon) {
    setState(() {
      screenStateName = nameOfActiveIcon;
    });
  }

  @override
  void initState() {
    handleScreenState('user');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hasAppBar = screenStateName == 'projects'
        ? null
        : AppBar(
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
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                                  name: widget.name,
                                  surname: widget.surname,
                                )));
                  },
                  child: const Row(children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.blue,
                    ),
                    Text('Мой аккаунт',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ))
                  ]),
                ),
                Positioned(
                    top: -5,
                    right: MediaQuery.of(context).size.width / 3,
                    child: const Text('Аккаунт'))
              ],
            ),
          );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 247, 247),
      appBar: hasAppBar,
      body: GetScreen(name: widget.name, surname: widget.surname)
          .getScreen(screenStateName),
      bottomNavigationBar: BottomNavBar(65, handleScreenState),
    );
  }
}

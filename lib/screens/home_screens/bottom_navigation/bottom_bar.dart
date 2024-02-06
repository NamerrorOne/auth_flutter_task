import 'package:auth_task/screens/home_screens/bottom_navigation/nav_icon.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar(this.height, this.callbackHandler, {super.key});

  final double height;
  final callbackHandler;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var activeIcon;
  void handleIconStateChanged(bool isActive, String iconName) {
    setState(() {
      activeIcons.forEach((key, value) {
        activeIcons[key] = false;
      });
      activeIcons[iconName] = isActive;
      activeIcon = iconName;
      widget.callbackHandler(iconName);
    });
  }

  final Map activeIcons = {
    'user': true,
    'projects': false,
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomAppBar(
          height: widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              NavIcon(
                  onIconStateChange: handleIconStateChanged,
                  widgetName: 'projects',
                  appStateActivity: activeIcons,
                  iconPath: 'assets/icons/projectsIcon.svg',
                  label: 'Мои проекты'),
              NavIcon(
                  onIconStateChange: handleIconStateChanged,
                  widgetName: 'user',
                  appStateActivity: activeIcons,
                  iconPath: 'assets/icons/userIcon.svg',
                  label: 'Мой аккаунт')
            ],
          ),
        ),
        Positioned(
          child: Container(
            height: 1,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}

import 'package:auth_task/screens/home_screens/body_sreen/body_screen_account/body_screen_user.dart';
import 'package:auth_task/screens/home_screens/body_sreen/body_screen_projects/body_screen_projects.dart';
import 'package:flutter/material.dart';

class GetScreen {
  GetScreen({this.name, this.surname});

  String? name;
  String? surname;

  Widget getScreen(String viewName) {
    switch (viewName) {
      case 'projects':
        return const ProjectsView();
      case 'user':
        return UserView(
          name: name,
          surname: surname,
        );
      default:
        return Container();
    }
  }
}

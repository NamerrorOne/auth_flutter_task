import 'dart:typed_data';

import 'package:auth_task/screens/home_screens/body_sreen/body_screen_account/account_widgets/account_textfield.dart';
import 'package:auth_task/screens/home_screens/body_sreen/body_screen_account/body_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UserView extends StatefulWidget {
  const UserView({
    super.key,
    this.name,
    this.surname,
  });

  final String? name;
  final String? surname;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  var state = '';

  void handleAndChangeState(stateFromIcon) {
    setState(() {
      state = stateFromIcon;
    });
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _image = img;
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 120,
                    width: 120,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                              'https://dk-almanah.ru/wp-content/uploads/2018/04/197-person-1824144.png',
                            ),
                          ),
                  ),
                  Positioned(
                      bottom: -4,
                      right: -4,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: SvgPicture.asset(
                          'assets/icons/downloadUserAvatar.svg',
                          height: 40,
                          width: 40,
                        ),
                      ))
                ],
              ),
            ],
          ),
          Column(
            children: [
              AccountTextInput(
                inputHintText: 'Имя',
                name: widget.name,
                surname: widget.surname,
                stateHandler: handleAndChangeState,
              ),
              AccountTextInput(
                stateHandler: handleAndChangeState,
                inputHintText: 'Фамилия',
                name: widget.name,
                surname: widget.surname,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

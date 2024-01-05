import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';

class EditMainInfo extends StatefulWidget {
  const EditMainInfo({super.key, required this.profile});
  final Profile profile;

  @override
  State<EditMainInfo> createState() => _EditMainInfoState();
}

class _EditMainInfoState extends State<EditMainInfo> {
  TextEditingController _nicknameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            //TODO: function to change profile image
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.width * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(widget.profile.profileImage, fit: BoxFit.cover),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Icon(
                  Icons.image,
                  size: MediaQuery.of(context).size.width * 0.18,
                  color: const Color.fromARGB(255, 48, 48, 48),
                )
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.18,
          width: MediaQuery.of(context).size.width * 0.45,
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
          child: TextField(
            controller: _nicknameController,
            decoration: InputDecoration(
              labelText: 'Change Nickname',
              hintText: widget.profile.nickname,
              labelStyle: const TextStyle(
                color: Colors.white, // fontcolor of label
                fontSize: 20.0, // fontsize of label
              ),
              hintStyle: const TextStyle(
                color: Colors.grey, // fontcolor of hint
                fontSize: 14.0, // fontsize of hint
              ),
            ),
            style: const TextStyle(
              color: Colors.white, // text color inside textfield
              fontSize: 18.0, // fontsize inside textfield
            ),
            cursorColor: Colors.blue, // cursor color
          ),
        )
      ],
    );
  }
}

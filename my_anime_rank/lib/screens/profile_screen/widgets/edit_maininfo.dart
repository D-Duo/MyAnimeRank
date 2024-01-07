import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';

class EditMainInfo extends StatefulWidget {
  const EditMainInfo({
    super.key,
    required this.profile,
    required this.nicknameController,
  });
  final Profile profile;
  final TextEditingController nicknameController;
  @override
  State<EditMainInfo> createState() => _EditMainInfoState();
}

class _EditMainInfoState extends State<EditMainInfo> {
  Future<String>? editImage;

  Future<void> _changeImage() async {
    setState(() {
      editImage = pickImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              //TODO: function to change profile image
              _changeImage();
            },
            child: FutureBuilder(
              future: editImage,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                widget.profile.profileImage =
                    snapshot.data ?? widget.profile.profileImage;
                editImage = null;
                return Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(widget.profile.profileImage,
                          fit: BoxFit.cover),
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
                );
              },
            )),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            controller: widget.nicknameController,
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

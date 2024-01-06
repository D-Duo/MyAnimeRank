import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';

class EditIdInfo extends StatefulWidget {
  const EditIdInfo({
    super.key,
    required this.profile,
    required this.mailController,
    required this.passwordController,
    required this.passwordVerficationController,
  });
  final Profile profile;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController passwordVerficationController;

  @override
  State<EditIdInfo> createState() => _EditIdInfoState();
}

class _EditIdInfoState extends State<EditIdInfo> {
  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //MAIL WIDGET
        const Text(
          "Mail",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 35.0, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          child: TextField(
            controller: widget.mailController,
            decoration: const InputDecoration(
              hintText: "Enter an email",
              hintStyle: TextStyle(
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
        ),
        //PASSWORD WIDGET
        const Text(
          "Password",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 35.0, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          child: TextField(
            controller: widget.passwordController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            cursorColor: Colors.blue,
            obscureText: _obscureText,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),
        //PASSWORD VERIFICATION WIDGET
        const Text(
          "Confirm Password",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 35.0, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.18,
          child: TextField(
            controller: widget.passwordVerficationController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            cursorColor: Colors.blue,
            obscureText: _obscureText2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText2 ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText2 = !_obscureText2;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';


class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              hoverColor: const Color.fromARGB(100, 19, 28, 39),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(100, 19, 28, 39))),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            IconButton(
              hoverColor: const Color.fromARGB(100, 19, 28, 39),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(100, 19, 28, 39))),
              icon: Icon(
                favorite ? Icons.favorite : Icons.heart_broken,
                color: favorite ? Colors.red : Colors.white,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  favorite = !favorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
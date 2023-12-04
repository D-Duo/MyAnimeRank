import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class CustomExpandable extends StatefulWidget {
  const CustomExpandable({
    super.key,
    required this.shortText,
    this.longText,
    this.triggerTextLess = "Show less...",
    this.triggerTextMore = "Read more...",
    this.height,
    this.width,
    this.textColor,
    this.triggerColor,
  });

  final String shortText;
  final String? longText;
  final String triggerTextLess;
  final String triggerTextMore;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? triggerColor;

  @override
  State<CustomExpandable> createState() => _CustomExpandableState();
}

class _CustomExpandableState extends State<CustomExpandable> {
  late ExpandableController _expandableController;

  @override
  void initState() {
    super.initState();
    _expandableController = ExpandableController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandablePanel(
            collapsed: Text(
              widget.shortText,
              style: TextStyle(
                color: widget.textColor ?? const Color.fromARGB(255, 174, 184, 197),
              ),
            ),
            expanded: Text(
              widget.longText ?? " ",
              softWrap: true,
              style: TextStyle(
                color: widget.textColor ?? const Color.fromARGB(255, 174, 184, 197),
              ),
            ),
            theme: const ExpandableThemeData(
              iconColor: Colors.blue,
              useInkWell: false,
            ),
            controller: _expandableController,
          ),
          // Expandable text TRIGGER
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  if (widget.longText != null)
                    GestureDetector(
                      onTap: () {
                        _expandableController.toggle();
                        setState(() {});
                      },
                      child: Text(
                        _expandableController.expanded
                            ? widget.triggerTextLess
                            : widget.triggerTextMore,
                        style: TextStyle(
                          color: widget.triggerColor ?? const Color.fromARGB(255, 252, 255, 85),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SeasonalFilterItem extends StatefulWidget {
  const SeasonalFilterItem(
      {super.key, required this.filter, required this.onValueChanged});

  final int filter;
  final void Function(int) onValueChanged;

  @override
  State<SeasonalFilterItem> createState() => _SeasonalFilterItemState();
}

class _SeasonalFilterItemState extends State<SeasonalFilterItem> {
  late int filter;
  late String buttonText;

  @override
  void initState() {
    super.initState();
    filter = widget.filter;
    buttonText = getDefaultText(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getEdgeInsetsItem(filter),
      child: Container(
          height: 30,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 54, 85, 131)),
          child: Row(
            children: [
              const SizedBox(
                height: 30,
                width: 10,
              ),
              Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              DropdownButton<int>(
                menuMaxHeight: 200,
                onChanged: (int? value) {
                  setState(() {
                    widget.onValueChanged(value!);
                    String text;
                    switch (value) {
                      case 0:
                        text = 'WINTER';
                        break;
                      case 1:
                        text = 'SPRING';
                        break;
                      case 2:
                        text = 'SUMMER';
                        break;
                      case 3:
                        text = 'FALL';
                        break;
                      default:
                        text = value.toString(); // Handle unexpected values
                    }
                    buttonText = text;
                  });
                },

                items: getDropdownItems(filter),
                underline: Container(), // Remove the underline
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 19, 28, 39),
              ),
            ],
          )),
    );
  }
}

EdgeInsets getEdgeInsetsItem(int filter) {
  switch (filter) {
    case 0:
      return const EdgeInsets.only(left: 20);
    case 1:
      return const EdgeInsets.only(right: 20);
    default:
      return const EdgeInsets.only(left: 20, right: 20);
  }
}

List<DropdownMenuItem<int>> getDropdownItems(int filter) {
  switch (filter) {
    case 0:
      return [0, 1, 2, 3].map((int choice) {
        String text;
        switch (choice) {
          case 0:
            text = 'WINTER';
            break;
          case 1:
            text = 'SPRING';
            break;
          case 2:
            text = 'SUMMER';
            break;
          case 3:
            text = 'FALL';
            break;
          default:
            text = ''; // Handle unexpected values
        }

        return DropdownMenuItem<int>(
          value: choice,
          child: Text(text, style: TextStyle(color: Colors.white)),
        );
      }).toList();
    case 1:
      // You can customize the range of years as needed
      int currentYear = DateTime.now().year;
      int startYear = 1999; // Change this to your desired starting year
      List<int> years = List.generate(
        currentYear - startYear + 1,
        (index) => (currentYear - index).toInt(),
      );
      return years.map((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString(), style: TextStyle(color: Colors.white)),
        );
      }).toList();
    default:
      return [0].map((int choice) {
        return DropdownMenuItem<int>(
          value: choice,
          child: Text('ERROR', style: TextStyle(color: Colors.white)),
        );
      }).toList();
  }
}

String getDefaultText(int filter) {
  switch (filter) {
    case 0:
      return getCurrentSeason();
    case 1:
      return DateTime.now().year.toString();
    default:
      return "ERROR";
  }
}

String getCurrentSeason() {
  final now = DateTime.now();
  final month = now.month;

  switch (month) {
    case 12:
    case 1:
    case 2:
      return 'WINTER';
    case 3:
    case 4:
    case 5:
      return 'SPRING';
    case 6:
    case 7:
    case 8:
      return 'SUMMER';
    case 9:
    case 10:
    case 11:
      return 'FALL';
    default:
      return 'UNKNOWN';
  }
}

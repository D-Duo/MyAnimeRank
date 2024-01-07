import 'package:flutter/material.dart';
import 'package:my_anime_rank/objects/profile.dart';

class EditSecondaryInfo extends StatefulWidget {
  const EditSecondaryInfo({
    super.key,
    required this.profile,
    required this.cityController,
    required this.countryController,
  });
  final Profile profile;
  final TextEditingController cityController;
  final TextEditingController countryController;
  @override
  State<EditSecondaryInfo> createState() => _EditSecondaryInfoState();
}

class _EditSecondaryInfoState extends State<EditSecondaryInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //CALENDAR WIDGET
        const Text(
          "BirthDay",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 20, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //DAY WIDGET
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.16,
              width: MediaQuery.of(context).size.width * 0.2,
              child: DropdownButtonFormField<int>(
                value: widget.profile.birthday.day,
                onChanged: (newValue) {
                  setState(() {
                    widget.profile.birthday.day = newValue ?? 1;
                  });
                },
                alignment: Alignment.bottomLeft,
                elevation: 0,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                ),
                focusColor: Colors.transparent,
                dropdownColor: const Color.fromARGB(255, 54, 85, 131),
                items: List.generate(
                    daysAmountPerMonth(widget.profile.birthday), (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(
                        color: Colors.grey, // text color inside dropdown
                        fontSize: 16.0, // fontsize inside dropdown
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            //MONTH WIDGET
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.16,
              width: MediaQuery.of(context).size.width * 0.3,
              child: DropdownButtonFormField<int>(
                value: widget.profile.birthday.month,
                onChanged: (newValue) {
                  setState(() {
                    widget.profile.birthday.month = newValue ?? 1;
                  });
                },
                alignment: Alignment.bottomLeft,
                elevation: 0,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                ),
                focusColor: Colors.transparent,
                dropdownColor: const Color.fromARGB(255, 54, 85, 131),
                items: List.generate(12, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text(
                      monthToString(index + 1),
                      style: const TextStyle(
                        color: Colors.grey, // text color inside dropdown
                        fontSize: 16.0, // fontsize inside dropdown
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            //YEAR WIDGET
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.16,
              width: MediaQuery.of(context).size.width * 0.2,
              child: DropdownButtonFormField<int>(
                value: widget.profile.birthday.year,
                onChanged: (newValue) {
                  setState(() {
                    widget.profile.birthday.year = newValue ?? 1;
                  });
                },
                alignment: Alignment.bottomLeft,
                elevation: 0,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                ),
                focusColor: Colors.transparent,
                dropdownColor: const Color.fromARGB(255, 54, 85, 131),
                items: List.generate(2024 - 1900, (index) {
                  return DropdownMenuItem<int>(
                    value: 1900 + index + 1,
                    child: Text(
                      (1900 + index + 1).toString(),
                      style: const TextStyle(
                        color: Colors.grey, // text color inside dropdown
                        fontSize: 16.0, // fontsize inside dropdown
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        //GENDER WIDGET
        const Text(
          "Gender",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 20, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonFormField<ProfileGender>(
          value: widget.profile.gender,
          onChanged: (newValue) {
            setState(() {
              widget.profile.gender = newValue ?? ProfileGender.unspecified;
            });
          },
          alignment: Alignment.bottomLeft,
          elevation: 0,
          decoration: const InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.start,
            counterText: "Kiko succiona pitos",
            counterStyle: TextStyle(color: Color.fromARGB(2, 255, 255, 255)),
          ),
          focusColor: Colors.transparent,
          dropdownColor: const Color.fromARGB(255, 54, 85, 131),
          items: ProfileGender.values.map((gender) {
            return DropdownMenuItem<ProfileGender>(
              value: gender,
              child: Text(
                genderToString(gender),
                style: const TextStyle(
                  color: Colors.grey, // text color inside dropdown
                  fontSize: 16.0, // fontsize inside dropdown
                ),
              ),
            );
          }).toList(),
        ),
        //LOCATION WIDGET
        const Text(
          "Location",
          style: TextStyle(
            color: Colors.white, // fontcolor of label
            fontSize: 20, // fontsize of label
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.18,
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.03),
              child: TextField(
                controller: widget.cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: widget.profile.location.city,
                  labelStyle: const TextStyle(
                    color: Colors.white, // fontcolor of label
                    fontSize: 16, // fontsize of label
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.18,
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextField(
                controller: widget.countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: widget.profile.location.country,
                  labelStyle: const TextStyle(
                    color: Colors.white, // fontcolor of label
                    fontSize: 16.0, // fontsize of label
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
        )
      ],
    );
  }
}

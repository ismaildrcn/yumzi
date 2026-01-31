import 'package:flutter/material.dart';
import 'package:yumzi/data/models/enums/user_gender.dart';

class GenderWidget extends StatelessWidget {
  final UserGender selectedGender;
  final ValueChanged<UserGender> onGenderChanged;

  const GenderWidget({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    Icon genderIcon;
    Color genderColor;

    if (selectedGender == UserGender.male) {
      genderIcon = Icon(Icons.male);
      genderColor = Theme.of(context).colorScheme.primary;
    } else if (selectedGender == UserGender.female) {
      genderIcon = Icon(Icons.female);
      genderColor = Colors.pink;
    } else {
      genderIcon = Icon(Icons.data_array);
      genderColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        UserGender nextGender;
        if (selectedGender == UserGender.male) {
          nextGender = UserGender.female;
        } else if (selectedGender == UserGender.female) {
          nextGender = UserGender.other;
        } else {
          nextGender = UserGender.male;
        }
        onGenderChanged(nextGender);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 14),
        decoration: BoxDecoration(
          color: genderColor.withAlpha(25),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: genderColor.withAlpha(25), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(genderIcon.icon, color: genderColor, size: 24),
            SizedBox(width: 6),
            Text(
              selectedGender.toString().split('.').last.toUpperCase(),
              style: TextStyle(
                color: genderColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

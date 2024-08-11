import 'package:flutter/material.dart';

import '../../../theme/theme_helper.dart';



class CustomRadioSelector extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String label;
  final String body;

  CustomRadioSelector({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? theme.colorScheme.primary : Colors.white,
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.grey,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),

                  Container(
                    height: 12.0,
                    width: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.grey,
                        width: 2.0,
                      ),
                      color: isSelected ? Colors.white : Colors.transparent,
                    ),
                    child: isSelected
                        ? Center(
                      child: Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                        : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
              child: Text(
                body,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
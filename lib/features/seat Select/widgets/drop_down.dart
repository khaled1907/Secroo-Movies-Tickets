import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  const CustomDropdown({required this.hintText, required this.items});

  @override
  State<CustomDropdown> createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: const Color(0xFF1A1D29),
          hint: Text(
            widget.hintText,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child:
                        Text(item, style: const TextStyle(color: Colors.white)),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.items,
      required this.onChanged,
      this.value,
      required this.labelText})
      : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final T? value;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 20, 20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          isDense: true,
          hint: const Text("Device"),
          itemHeight: 50,
          items: items,
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData data;
  final String label;
  final String value;
  const AdditionalInfo({
    super.key, required this.data, required this.label, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(
          data,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(label),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style:const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

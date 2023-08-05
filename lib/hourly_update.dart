import 'package:flutter/material.dart';

class UpdateBox extends StatelessWidget {
  final String time;
  final IconData icon;
  final String value;

  const UpdateBox({
    super.key,
    required this.time,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Icon(
                    icon,
                    size: 32,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

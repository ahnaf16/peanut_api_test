import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class InfoTile extends StatelessWidget {
  const InfoTile(this.icon, this.label, this.value, {super.key});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: context.colors.primary.op7),
      title: Text(label, style: TextStyle(fontSize: 12, color: context.colors.secondary)),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontFamily: 'monospace',
        ),
      ),
      dense: true,
    );
  }
}

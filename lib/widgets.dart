import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const ProductivityButton({
    super.key,
    required this.color,
    required this.text,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;
  const SettingButton(
    {
    super.key,
     required this.color,
    required this.text,
    required this.size,
    required this.value,
    required this.setting,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

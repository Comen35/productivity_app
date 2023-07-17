import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late int? workTime;
  late int? shortBreak;
  late int? longBreak;
  int buttonSize = 5;

  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  TextStyle textStyle = const TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: [
        Text("Work", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
          color: const Color(0xff455a64),
          text: '-',
          value: -1,
          callback: updateSetting,
          setting: WORKTIME,
          size: 5,
        ),
        TextField(
          controller: txtWork,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
          color: const Color(0xff009688),
          text: '+',
          value: 1,
          callback: updateSetting,
          setting: WORKTIME,
          size: 5,
        ),
        Text("Short", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
          color: const Color(0xff455a64),
          text: '-',
          value: -1,
          callback: updateSetting,
          setting: SHORTBREAK,
          size: 5,
        ),
        TextField(
          controller: txtShort,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
          color: const Color(0xff009688),
          text: "+",
          value: 1,
          callback: updateSetting,
          setting: SHORTBREAK,
          size: 5,
        ),
        Text("Long", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
          color: const Color(0xff455a64),
          text: '-',
          value: -1,
          callback: updateSetting,
          setting: LONGBREAK,
          size: 5,
        ),
        TextField(
          controller: txtLong,
          style: textStyle,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        SettingButton(
          color: const Color(0xff009688),
          text: '+',
          value: 1,
          callback: updateSetting,
          setting: LONGBREAK,
          size: 5,
        ),
      ],
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME)!;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK)!;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK)!;
          long += value;
          if (long >= 1 && long <= 120) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}

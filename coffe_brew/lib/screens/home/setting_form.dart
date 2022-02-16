import 'package:coffe_brew/models/user_data.dart';
import 'package:coffe_brew/services/database.dart';
import 'package:coffe_brew/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of<UserData>(context);
    return StreamBuilder<UserDataDetail>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataDetail? userdata = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userdata!.name,
                    decoration: textInputStyle,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userdata.sugars,
                    decoration: textInputStyle,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  Slider(
                      min: 100.0,
                      max: 900.0,
                      activeColor:
                          Colors.brown[_currentStrength ?? userdata.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userdata.strength],
                      // activeColor: Colors.brown,
                      value: (_currentStrength ?? userdata.strength).toDouble(),
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.toInt();
                        });
                      }),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: userdata.uid)
                              .updateUserData(
                                  _currentSugars ?? userdata.sugars,
                                  _currentName ?? userdata.name,
                                  _currentStrength ?? userdata.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Update')),
                ],
              ),
            );
          } else {
            return const SpinKitWave(
              color: Colors.pink,
              size: 50.0,
            );
          }
        });
  }
}

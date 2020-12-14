import 'package:brew_crew/models/user_bc.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName, _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final userBC = Provider.of<UserBC>(context);

    return StreamBuilder<UserBCData>(
        stream: DatabaseService(uid: userBC.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserBCData userBCData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? userBCData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (value) => value.isEmpty ? 'Enter a name' : null,
                    onChanged: (value) {
                      setState(() => _currentName = value);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userBCData.sugars,
                    onChanged: (value) {
                      setState(() => _currentSugars = value);
                    },
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // slider
                  Slider(
                    value: (_currentStrength ?? userBCData.strength).toDouble(),
                    onChanged: (value) {
                      setState(
                          () => _currentStrength = value.round()); //  as int
                    },
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userBCData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userBCData.strength],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: userBC.uid).updateUserData(
                            _currentSugars ?? userBCData.sugars,
                            _currentName ?? userBCData.name,
                            _currentStrength ?? userBCData.strength);
                        Navigator.pop(context);
                        // setState(() => loading = true);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

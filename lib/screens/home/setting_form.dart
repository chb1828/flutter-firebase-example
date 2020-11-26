import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/member.dart';
import 'package:flutter_and_firebase/services/database.dart';
import 'package:flutter_and_firebase/shared/constants.dart';
import 'package:flutter_and_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0","1","2","3","4"];

  //form values;
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Member>(context);
    return StreamBuilder<MemberData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot) {
        if(snapshot.hasData) {
          MemberData memberData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your brew settings",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: memberData.name,
                  decoration: textInputDecoration,
                  validator: (value) => value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) {
                    setState(() => _currentName = value);
                  },
                ),
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? memberData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _currentSugars = value);
                  },
                ),
                Slider(
                  value: (_currentStrength ?? memberData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? memberData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? memberData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (value) => setState(()=> _currentStrength = value.round()),
                ),
                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? memberData.sugars,
                          _currentName ?? memberData.name,
                          _currentStrength ?? memberData.strength);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        }else {
          return Loading();
        }

      },
    );
  }
}


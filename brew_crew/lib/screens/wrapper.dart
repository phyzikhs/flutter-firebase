import 'package:brew_crew/models/user_bc.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBC = Provider.of<UserBC>(context);
    print(userBC);

    // return either home or authenticate widget
    return (userBC == null) ? Authenticate() : Home();
  }
}

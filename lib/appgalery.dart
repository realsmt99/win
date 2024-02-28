import 'package:flutter/material.dart';
import 'package:win/features/auth/screen/login_screen.dart';
import 'package:win/features/home/screen/home.dart';

class AppGalery extends StatefulWidget {
  const AppGalery({super.key});

  @override
  State<AppGalery> createState() => _AppGaleryState();
}

class _AppGaleryState extends State<AppGalery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text("Login"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ));
            },
          )
        ],
      ),
    );
  }
}

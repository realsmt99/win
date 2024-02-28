import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool checked = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to the app, please login to continue",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formkey,
                    canPop: true,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            (value.contains('@') &&
                                    value.contains('.') &&
                                    value.length > 5)
                                ? null
                                : 'Please enter a valid email';
                            return null;
                          },
                          controller: _email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            (value.contains('@') &&
                                    value.contains('.') &&
                                    value.length > 5)
                                ? null
                                : 'please enter a valid password';
                            return null;
                          },
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: checked,
                                onChanged: (value) {
                                  setState(() {
                                    checked = value!;
                                  });
                                }),
                            Text("I agree to the terms and conditions"),
                          ],
                        ),
                        FilledButton(
                            style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size(200, 20)),
                            ),
                            onPressed: () async {
                              if (formkey.currentState!.validate() &&
                                  checked) {}
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Login"),
                                Icon(Icons.login_sharp),
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

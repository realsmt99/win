import 'package:flutter/material.dart';
import 'package:win/const.dart';
import 'package:win/features/auth/screen/login_screen.dart';
import 'package:win/features/auth/services/auth_services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  late TextEditingController _email;
  late TextEditingController _password;

  late TextEditingController _displayName;
  late TextEditingController _phoneNumber;

  bool checked = false;
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
    _displayName = TextEditingController();
    _phoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _displayName.dispose();
    _email.dispose();
    _password.dispose();
    _phoneNumber.dispose();
  }

  bool isloading = false;
  void signupuser() async {
    String res = await AuthMethods().signupUser(
        email: _email.text.trim(),
        password: _password.text.trim(),
        displayName: _displayName.text,
        phoneNumber: _phoneNumber.text.trim());

    if (res == "Signed up") {
      if (mounted) showSnackBar("Signed up", context);
      if (mounted)
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
    } else {
      setState(() {
        isloading = false;
      });
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to the app please login to continue",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: signupKey,
                    canPop: true,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                            (value.length > 5)
                                ? null
                                : 'Please enter a valid email';
                            return null;
                          },
                          controller: _displayName,
                          decoration: InputDecoration(
                            labelText: 'Display Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
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
                          controller: _phoneNumber,
                          decoration: InputDecoration(
                            labelText: 'Phonenumber',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Phonenumber';
                            }
                            (value.length >= 9)
                                ? null
                                : 'please enter a valid Phonenumber';
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
                              if (signupKey.currentState!.validate() &&
                                  checked) {
                                setState(() {
                                  isloading = true;
                                });
                                signupuser();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Create my Account"),
                                isloading
                                    ? Flexible(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      )
                                    : Container()
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

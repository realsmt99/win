import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lib/lib.dart';
import 'package:provider/provider.dart';
import 'package:win/features/auth/services/auth_services.dart';
import 'package:win/features/home/screen/onbording.dart';
import 'package:win/features/problemrequest/screens/report_problem_page.dart';
import 'package:win/models/profile_model.dart';
import 'package:win/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  static final currentPartNotifier = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset('assets/image-removebg-preview.png',
            height: 90, width: 90),
      ),
      body: ValueListenableBuilder(
          valueListenable: currentPartNotifier,
          builder: (context, value, child) {
            return PageTransitionSwitcher(
              duration: const Duration(milliseconds: 500),
              reverse: currentPartNotifier.value == 0,
              transitionBuilder: (child, animation, secondaryAnimation) {
                // use fade through transition
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                );
              },
              child: [Onboarding(), View2(), View3()].elementAt(value),
            );
          }),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentPartNotifier,
        builder: (context, value, child) {
          return NavigationBar(
            selectedIndex: value,
            onDestinationSelected: (index) {
              currentPartNotifier.value = index;
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.home),
                label: 'overview',
              ),
              NavigationDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.headphones_outlined),
                selectedIcon: Icon(Icons.headphones_rounded),
                label: 'Help',
              ),
            ],
          );
        },
      ),
    );
  }
}

class View1 extends StatelessWidget {
  const View1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("view1"),
    );
  }
}

class View2 extends StatelessWidget {
  const View2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //create a beautiful widget saying welcome back to our platform report the problem you currently facing
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Welcome back to our platform",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Report the problem you currently facing",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReportProblemPage()));
                            },
                            child: Text("Report Problem"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                        "assets/AT-campaign-family-150-banner-1600-450-en-1693.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class View3 extends StatefulWidget {
  const View3({super.key});

  @override
  State<View3> createState() => _View3State();
}

class _View3State extends State<View3> {
  ProfileModel user =
      ProfileModel(displayName: " ", email: " ", phoneNumber: " ", uid: " ");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          launchUrl(Uri.parse(
              "https://creator.voiceflow.com/prototype/65e07e664702aca0020f0161"));
        },
        child: Text("Chat with our bot"),
      )),
    );
  }
}

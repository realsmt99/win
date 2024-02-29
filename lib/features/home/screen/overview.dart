import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              child: [View1(), View2(), View3()].elementAt(value),
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
    return Scaffold(
        body: Center(
      child: Text("view1"),
    ));
  }
}

class View2 extends StatelessWidget {
  const View2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("view2"),
      ),
    );
  }
}

class View3 extends StatelessWidget {
  const View3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("view3"),
      ),
    );
  }
}

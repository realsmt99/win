// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lib/lib.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:win/features/auth/services/auth_services.dart';
import 'package:win/features/home/screen/onbording.dart';
import 'package:win/features/problemrequest/screens/report_problem_page.dart';
import 'package:win/models/problemrequest_problem.dart';
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
        actions: [
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Iconsax.notification)),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              child: Icon(Iconsax.user),
            ),
          ),
        ],
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome back to our platform",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
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
        ),
        ListTile(
          title: Text("Find the best offers for you"),
          trailing: TextButton(onPressed: () {}, child: Icon(Iconsax.activity)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PanelBar(
            title: Text("Our Services"),
            action: TextButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse("https://www.algerietelecom.dz/en/produits"));
                },
                child: Text("See all")),
          ),
        ),
        Card(
            child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueAccent,
                Colors.blueGrey,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back to our platform",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                        Text(
                          "Report the problem you currently facing",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 190,
                            ),
                            FilledButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ReportProblemPage()));
                                },
                                child: Text("Report Problem")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PanelBar(
            title: Text("My Latest Problems"),
            action: TextButton(onPressed: () {}, child: Text("See all")),
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("ProblemRequests")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (var i = 0; i < snapshot.data!.docs.length; i++)
                      Problems(
                        problemRequest:
                            ProblemRequest.fromJson(snapshot.data!.docs[i]),
                      ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

class Problems extends StatefulWidget {
  final ProblemRequest problemRequest;
  const Problems({
    Key? key,
    required this.problemRequest,
  }) : super(key: key);

  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                onTap: () {},
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.zero,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(
                            widget.problemRequest.attachements.first),
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14),
                  title: Text(widget.problemRequest.clientuid),
                  subtitle: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.problemRequest.status == "pending"
                              ? Colors.grey.withOpacity(0.2)
                              : widget.problemRequest.status == "inprogress"
                                  ? Colors.blue.withOpacity(0.2)
                                  : widget.problemRequest.status == "completed"
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.problemRequest.status,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: widget.problemRequest.status == "pending"
                                  ? Colors.grey
                                  : widget.problemRequest.status == "inprogress"
                                      ? Colors.blue
                                      : widget.problemRequest.status ==
                                              "completed"
                                          ? Colors.green
                                          : Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),

                  /// Generate in the trailing a list of technicians,
                  /// if the list is empty, show nothing in the trailing
                  /// if the list is not empty, show the first 2 technicians embeded in circle avatars
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 2,
                color: widget.problemRequest.status == "pending"
                    ? Colors.grey.withOpacity(0.2)
                    : widget.problemRequest.status == "inprogress"
                        ? Colors.blue.withOpacity(0.2)
                        : widget.problemRequest.status == "completed"
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "${"Problem Request"} N°${widget.problemRequest.problemid.substring(0, 6)}",
                        //'Machine of typeX not working'.tr()
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.problemRequest.problemDescription,

                            //'This Problem is happening since day 2.....'.tr(),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          Row(
                            children: [
                              Text('Request Time', //TODO Translate in french
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              Text(
                                ": ${widget.problemRequest.createdAt.toIso8601String()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Problem Time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              Text(
                                ": ${widget.problemRequest.createdAt.toIso8601String()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                widget.problemRequest.attachements.length
                                    .toString(),
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Iconsax.document_upload,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Container(height: 1, color: Colors.grey.withOpacity(0.2)),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('See'),
                        ),
                      ),
                    ),
                    /* Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 1,
                        height: 30,
                        color: Colors.grey.withOpacity(0.2)),
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Cancel'),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

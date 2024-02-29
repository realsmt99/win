import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:win/const.dart';
import 'package:win/features/problemrequest/services/problen_services.dart';
import 'package:win/storage_services.dart';

class ReportProblemPage extends StatefulWidget {
  const ReportProblemPage({super.key});

  @override
  State<ReportProblemPage> createState() => _ReportProblemPageState();
}

class _ReportProblemPageState extends State<ReportProblemPage> {
  ProblemType _selectedProblem = ProblemType.adsl;

  Uint8List? _file;

  late TextEditingController fixPhoneNumber;
  late TextEditingController captioncontroller;

  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Upload Image"),
            children: [
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("Photo with Camera"),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("Image from Gallery"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        });
  }

  void postImage() async {
    try {
      String res = await ProblemServices().uploadRequest(
        uid: FirebaseAuth.instance.currentUser!.uid,
        problemType: _selectedProblem.toString(),
        file: _file!,
        caption: captioncontroller.text,
      );

      if (res == "Success") {
        showSnackBar("Request Uploaded Successfuly", context);
        Navigator.of(context).pop();
      } else {
        ShowSnackBar(res, context);
      }
    } catch (e) {
      ShowSnackBar(e.toString(), context);
    }
  }

  @override
  void initState() {
    captioncontroller = TextEditingController();
    fixPhoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fixPhoneNumber.dispose();
    captioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey<FormState>(),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: FilledButton(
              style: FilledButton.styleFrom(
                fixedSize: Size(100, 30),
              ),
              onPressed: () {
                postImage();
              },
              child: Text("Submit your request")),
        ),
        appBar: AppBar(
          elevation: 4,
          title: Text("Report a problem"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionTile(
                title: Text("Select a category"),
                children: [
                  RadioListTile<ProblemType>(
                    title: const Text('ADSL'),
                    value: ProblemType.adsl,
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      setState(() {
                        _selectedProblem = value!;
                      });
                    },
                  ),
                  RadioListTile<ProblemType>(
                    title: const Text('Help'),
                    value: ProblemType.help,
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      setState(() {
                        _selectedProblem = value!;
                      });
                    },
                  ),
                ],
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
                controller: fixPhoneNumber,
                decoration: InputDecoration(
                  labelText: 'Phone Fix number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: captioncontroller,
                minLines: 2,
                maxLines: 5,
                maxLength: 1000,
                // decoration: InputDecoration(
                //   prefixIcon: Icon(Icons.speaker_notes,
                //       color:
                //           Theme.of(context).primaryColor),

                //   // add some space between the text and the border
                //   contentPadding: EdgeInsets.symmetric(
                //       horizontal: 14, vertical: 10),

                //   filled: true,
                //   fillColor: Theme.of(context)
                //       .textSelectionTheme
                //       .selectionColor,
                // ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.speaker_notes,
                      color: Theme.of(context).primaryColor),
                  hintText: 'write something here...',
                  hintStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  labelText: 'Description of the problem',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              if (_file != null)
                Image.memory(
                  _file!,
                  height: 200,
                  width: 200,
                ),
              ElevatedButton(
                  onPressed: () {
                    selectImage(context);
                  },
                  child: Text("Select Image")),
            ],
          ),
        ),
      ),
    );
  }
}

enum ProblemType {
  adsl,
  help,
}

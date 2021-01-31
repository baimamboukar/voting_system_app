import 'dart:io';

import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddVoteOptionWidget extends StatefulWidget {
  @override
  _AddVoteOptionWidgetState createState() => _AddVoteOptionWidgetState();
}

class _AddVoteOptionWidgetState extends State<AddVoteOptionWidget> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  File _imagePicked;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UploadTask _uploadTask;
  double progressPercent = 0.0;
  var imgURL;
  void startUpload() async {
    String filePath = "election_pics/${DateTime.now()}.png";
    var reference = _storage.ref().child(filePath);

    setState(() {
      _uploadTask = reference.putFile(_imagePicked);
      _uploadTask.then((snapshot) {
        setState(() {
          imgURL = Future.value(snapshot.ref.getDownloadURL());
          Get.back();
          print("Image URL ${imgURL.toString()}");
        });
        print("Image URL ${imgURL.toString()}");
      });
    });

    // await _uploadTask.then((snapshot) {
    //   setState(() {
    //     imgURL = snapshot.ref.getDownloadURL();
    //   });
    //   print("Image URL $imgURL");
    // });
  }

  Future<void> pickImage(ImageSource source) async {
    PickedFile selectedImage = await ImagePicker().getImage(
        source: source, maxHeight: 300.0, maxWidth: 300.0, imageQuality: 100);
    setState(() {
      if (selectedImage != null) {
        _imagePicked = File(selectedImage.path);
        Navigator.pop(context);
        Get.dialog(
            AlertDialog(
              // contentPadding: const EdgeInsets.only(top: 200.0, bottom: 200.0),
              title: Text("Candidate Image Upload"),
              content: Container(
                height: 320.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(
                        _imagePicked,
                        filterQuality: FilterQuality.high,
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 20.0),
                      _uploadTask != null
                          ? StreamBuilder(
                              stream: _uploadTask.snapshotEvents,
                              builder: (context, snapshot) {
                                _uploadTask.snapshotEvents
                                    .listen((TaskSnapshot snapshot) {
                                  setState(() {
                                    progressPercent =
                                        snapshot.bytesTransferred.toDouble() /
                                            snapshot.totalBytes.toDouble();
                                  });
                                });

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 45.0, right: 45.0),
                                      child: LinearProgressIndicator(
                                          semanticsLabel:
                                              "${(progressPercent * 100).toString()} % uploaded...",
                                          minHeight: 10.0,
                                          value: progressPercent * 100),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "${(progressPercent * 100).toString()} % uploaded...",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                );
                              })
                          : ElevatedButton.icon(
                              onPressed: () {
                                startUpload();
                              },
                              icon: Icon(Icons.upload_file),
                              label: Text("Upload Image")),
                    ],
                  ),
                ),
              ),
            ),
            arguments: Get.arguments);
      } else {
        Get.snackbar("ERROR", "No Image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Arrrrrrrrguments ${Get.arguments}");
    var _candidateNameController = TextEditingController();
    var _candidateDescriptionController = TextEditingController();
    Get.put(ElectionController());

    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Image(
                  image: AssetImage('assets/icons/logo.png'),
                  height: 80.0,
                  width: 300.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "ADD OPTION OR CANDIDATE",
              style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Get.bottomSheet(
                    Container(
                      color: Colors.white,
                      height: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                ImageSource _source = ImageSource.gallery;
                                pickImage(_source);
                              },
                              icon: Icon(
                                Icons.image_outlined,
                                color: Colors.red,
                              ),
                              label: Text("Pick from Gallery")),
                          ElevatedButton.icon(
                              onPressed: () {
                                ImageSource _source = ImageSource.camera;
                                pickImage(_source);
                              },
                              icon: Icon(
                                Icons.camera_enhance,
                                color: Colors.green,
                              ),
                              label: Text("Take picture with Camera"))
                        ],
                      ),
                    ),
                    settings: RouteSettings(arguments: Get.arguments));
                setState(() {
                  _imagePicked = null;
                });
              },
              child: FutureBuilder(
                  future: Future.value(imgURL),
                  builder: (context, state) {
                    if (state.hasData) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(state.data),
                        radius: 80.0,
                      );
                    }
                    return CircleAvatar(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.account_circle,
                                size: 84.0,
                              ),
                            ),
                            Center(
                              child: Text("Add Image"),
                            )
                          ],
                        ),
                      ),
                      radius: 80.0,
                    );
                  }),
            ),
            SizedBox(
              height: 40.0,
            ),
            InputField(
              prefixIcon: Icons.person,
              hintText: 'Candidate\'s names',
              controller: _candidateNameController,
              obscure: false,
            ),
            InputField(
              prefixIcon: Icons.edit,
              hintText: 'Candidates\'s description',
              controller: _candidateDescriptionController,
              obscure: false,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () async {
          imgURL = imgURL ?? "gs://electchain-8ea68.appspot.com/avatar.jpg";
          var result = await DataBase().addCandidate(
              Get.arguments[0].id.toString(),
              imgURL,
              _candidateNameController.text,
              _candidateDescriptionController.text);

          if (result) {
            Get.back();
          }
        },
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
      ),
    );
  }
}

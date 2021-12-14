import 'dart:io';

import 'package:alemeno_sarthak/api/firebase_api.dart';
import 'package:alemeno_sarthak/constants.dart';
import 'package:alemeno_sarthak/dialogbox/good_job_dialog.dart';
import 'package:alemeno_sarthak/methods.dart';
import 'package:alemeno_sarthak/methods/methods.dart';
import 'package:alemeno_sarthak/services/notification_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClickPicPage extends StatefulWidget {
  const ClickPicPage({Key? key}) : super(key: key);

  @override
  _ClickPicPageState createState() => _ClickPicPageState();
}

class _ClickPicPageState extends State<ClickPicPage> {
  dynamic _image;
  final _picker = ImagePicker();
  bool loadingImage = false;
  ImageSource source = ImageSource.gallery;
  UploadTask? task;

  pickImage() async {
    setState(() {
      loadingImage = true;
    });
    final image = await _picker.pickImage(
      source: source,
      // imageQuality: 50,
    );

    String? path = image?.path;
    if (image != null) {
      setState(() {
        _image = File(path.toString());
      });
    }
    setState(() {
      loadingImage = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Constants().mainGreen,
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                  elevation: 5,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Image.network(
              "https://s3-alpha-sig.figma.com/img/372e/29d2/61ffd04d292bdf4e6f948177bf8f8a39?Expires=1640563200&Signature=TCNqD7wvZH2NFMileEBQOosAQPHTwqWSDTWrdfwTrahd4w1D4yyATrBsf00~9DLh3rn4qg46DcZX24kRhuFsBQ462K0OaICESygExNyApLNJcfAY5jlO6bl8BzHC4le56XcrsXsBLZjOGdYsChrtAoI9nwSsXaa58MTCh3OYQCs3C1fXyxt8nE5KISXQeQvYIjj0vH8DoUlULzvR6Vc9XaV5MB1ax0y8WSQC~T0f98fHlM6gMkAU3BzSsE1j02WYidu68LrU4D~RljZrGtavdi0scGtd2zylV835-kE6FSfXrv9bpmMZe2VXZ-u9fjzCM-avpVKc2vL-UUHIWLIp~g__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA",
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/Fork.png"),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.50,
                                margin: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Constants().mainGreen,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: loadingImage
                                    ? FractionallySizedBox(
                                        widthFactor: 0.3,
                                        heightFactor: 0.3,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: Constants().mainGreen,
                                        ),
                                      )
                                    : ((_image != null)
                                        ? CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            backgroundImage: FileImage(
                                              _image,
                                            ),
                                            backgroundColor: Colors.transparent,
                                          )
                                        : Container()),
                              ),
                            ],
                          ),
                        ),
                        Image.asset("assets/images/Vector.png"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      (_image == null)
                          ? "Click your meal"
                          : "Will you eat this?",
                      style: textStyle(20, Colors.black),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: (_image == null)
                        ? ElevatedButton(
                            onPressed: () async {
                              await chooseImageSource(context);
                              await pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Constants().mainGreen,
                              shape: const CircleBorder(),
                              elevation: 5,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  await uploadFile(_image!);
                                  await NotificationService().Notify(
                                      "Thank you for sharing food with me");
                                  await showGeneralDialog(
                                    context: context,
                                    pageBuilder: (BuildContext buildContext,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return const GoodjobDialog();
                                    },
                                  );

                                  setState(() {
                                    _image = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Constants().mainGreen,
                                  shape: const CircleBorder(),
                                  elevation: 5,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              if (task != null)
                                Methods().showUplaodStatus(task!),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Constants().mainGreen,
                                  shape: const CircleBorder(),
                                  elevation: 5,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> chooseImageSource(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      source = ImageSource.camera;
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.camera_alt),
                      SizedBox(width: 5),
                      Text("Camera"),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      source = ImageSource.gallery;
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.image),
                      SizedBox(width: 5),
                      Text("Gallery"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future uploadFile(File image) async {
    print("Uploading");
    if (image == null) return;
    final fileName = image!.path.toString().split('/').last;
    print("filename: $fileName");
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, image);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
  }
}

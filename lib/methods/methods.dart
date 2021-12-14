import 'dart:io';

import 'package:alemeno_sarthak/api/firebase_api.dart';
import 'package:alemeno_sarthak/constants.dart';
import 'package:alemeno_sarthak/methods.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Methods {
  UploadTask? task;
  Future uploadFile(File image) async {
    if (image == null) return;
    final fileName = image!.path.toString().split('/').last;

    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, image);
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
  }

  Widget showUplaodStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            final progress =
                (((data!.bytesTransferred / data.totalBytes) * 10000).floor()) /
                    100;

            return Text(
              "$progress %",
              style: textStyle(15, Colors.black),
            );
          } else {
            return Container();
          }
        },
      );
}

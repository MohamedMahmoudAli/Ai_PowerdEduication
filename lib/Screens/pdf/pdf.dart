import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Pdf extends StatefulWidget {
  static const String routeName = 'pdf';

  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  PlatformFile? PickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${PickedFile!.name}';
    final file = File(PickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
   await ref.putFile(file);
    String fileUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('files').add({'name': fileUrl,'title':PickedFile!.name});



  }

  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(() {
      PickedFile = result!.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/pdf.png',
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            if (PickedFile != null)
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.15,
                color: AppColor.primaryColor,
                child: Center(
                  child: Text(
                    PickedFile!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryColor)),
                  onPressed: SelectFile,
                  child:  Text(
                    "${AppLocalizations.of(context)!.selectPdf}",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryColor)),
                  onPressed: ()async {
                 await   uploadFile();
                    setState(() {
                      PickedFile = null;
                    });
                    Fluttertoast.showToast(
                      msg: 'Uploaded',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColor.primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                  },
                  child:  Text(
                    "${AppLocalizations.of(context)!.upLoadPdf}",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

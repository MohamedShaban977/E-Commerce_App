import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';

class StorageImage extends ChangeNotifier {
  File fileImage;
  var imageDownload;
  String url;
  String urlStore;
  var updateImageUrl;
  var path;

  final FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://e-commerce-buyit.appspot.com');

  void pickImage(context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff325F6D),
      elevation: 1,
      title: Text("Chose the image"),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
      content: Text("Please select a picture from the camera or gallery"),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                  onPressed: () {
                    getImageCamera();
                    Navigator.pop(context);
                  },
                  color: Color(0xffC34072),
                  textColor: Colors.white),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton.icon(
                  icon: Icon(
                    Icons.image,
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 50),
                  label: Text('Gallery'),
                  onPressed: () async {
                    getImageGallery();

                    Navigator.pop(context);
                  },
                  color: Color(0xffC34072),
                  textColor: Colors.white),
            ),
            SizedBox(height: 20),
            IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 40,
                  color: Colors.white70,
                ),
                onPressed: () => Navigator.pop(context)),
          ],
        ),
        SizedBox(),
        SizedBox(),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void uploadImage(context) async {
    notifyListeners();

    try {
      // FirebaseStorage storage =
      //     FirebaseStorage(storageBucket: 'gs://e-commerce-buyit.appspot.com');

      StorageReference ref = storage.ref().child(Path.basename(fileImage.path));
      StorageUploadTask uploadTask = ref.putFile(fileImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Success Upload Image')));

      urlStore = await taskSnapshot.ref.getDownloadURL();
      print(urlStore);

      url = urlStore;
    } catch (ex) {
      // print(ex.toString());
      Fluttertoast.showToast(
          msg: fileImage == null ? "Please choose Image" : ex.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          timeInSecForIosWeb: 5,
          fontSize: 18);
    }
    fileImage = null;
    // urlStore = null;
  }

  ///downloadImage
  // downloadImage(imageUrl) async {
  //
  //   try {
  //     // Saved with this method.
  //     var imageId = await ImageDownloader.downloadImage(imageUrl);
  //     if (imageId == null) {
  //       return;
  //     }
  //
  //     // Below is a method of obtaining saved image information.
  //      imageDownload = await ImageDownloader.findName(imageId);
  //     var path = await ImageDownloader.findPath(imageId);
  //     var size = await ImageDownloader.findByteSize(imageId);
  //     var mimeType = await ImageDownloader.findMimeType(imageId);
  //   } on PlatformException catch (error) {
  //     print(error);
  //   }
  //   // try {
  //   //   var imageId = await ImageDownloader.downloadImage(imageUrl);
  //   //   var path = await ImageDownloader.findPath(imageId);
  //   //
  //   //   await ImageDownloader.findByteSize(imageId);
  //   //   await ImageDownloader.findMimeType(imageId);
  //   //   await ImageDownloader.findName(imageId);
  //   //   await ImageDownloader.open(path);
  //   //
  //   //   File image = File('$path');
  //   //   imageDownload = image;
  //   //   print(image);
  //   //   Fluttertoast.showToast(
  //   //       msg: "Image downloaded",
  //   //       toastLength: Toast.LENGTH_SHORT,
  //   //       gravity: ToastGravity.BOTTOM,
  //   //       backgroundColor: Colors.white,
  //   //       textColor: Colors.black,
  //   //       timeInSecForIosWeb: 5,
  //   //       fontSize: 18);
  //   //   notifyListeners();
  //   // } catch (ex) {
  //   //   Fluttertoast.showToast(
  //   //       msg: ex.toString(),
  //   //       toastLength: Toast.LENGTH_SHORT,
  //   //       gravity: ToastGravity.BOTTOM,
  //   //       backgroundColor: Colors.white,
  //   //       textColor: Colors.black,
  //   //       timeInSecForIosWeb: 5,
  //   //       fontSize: 18);
  //   // }
  //
  //   // try {
  //   //   // Saved with this method.
  //   //   var imageId = await ImageDownloader.downloadImage("https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
  //   //   if (imageId == null) {
  //   //     return;
  //   //   }
  //   //
  //   //   // Below is a method of obtaining saved image information.
  //   //   var fileName = await ImageDownloader.findName(imageId);
  //   //   var path = await ImageDownloader.findPath(imageId);
  //   //   var size = await ImageDownloader.findByteSize(imageId);
  //   //   var mimeType = await ImageDownloader.findMimeType(imageId);
  //   // } on PlatformException catch (error) {
  //   //   print(error);
  //   // }
  // }

  Future<void> save(imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));

    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    var result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
    );
    // path = result['filePath'];
    print(result);
    imageDownload = result['filePath'];
    print(imageDownload);
  }

  void getImageGallery() async {
    var imageGallery = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileImage = imageGallery;
    notifyListeners();
  }

  getImageCamera() async {
    var imageCamera = await ImagePicker.pickImage(source: ImageSource.camera);

    fileImage = imageCamera;
    notifyListeners();
  }

  openImage(context, String urlImage) {
    notifyListeners();

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white38,
      content: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            image: fileImage != null
                ? FileImage(fileImage)
                : NetworkImage(urlImage),
          ),
          IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.black38,
                size: 40,
              ),
              onPressed: () => Navigator.pop(context)),
          Positioned(
            right: 0,
            child: IconButton(
                icon: imageDownload == null
                    ? Icon(Icons.download_sharp,
                        color: Colors.black38, size: 40)
                    : Icon(Icons.done, color: Colors.black38, size: 40),
                onPressed: () async {
                  imageDownload = null;

                  if (imageDownload == null) {
                    await save(urlImage);
                    imageDownload = null;
                  }
                  imageDownload = null;

                  print(imageDownload);
                }),
            // TweenAnimationBuilder<IconData>(
            //     duration: Duration(seconds: 2),
            //     tween: Tween(
            //       end: Icons.done,
            //     ),
            //     builder: (context, icon, Widget __) => IconButton(
            //         icon: Icon(Icons.download_sharp), onPressed: () {
            //
            //     })),
            // // onPressed: () async {
            //   changeIcon();
            //   notifyListeners();
            //   imageDownload = null;
            //
            //   if (imageDownload == null) {
            //     await save(urlImage);
            //     imageDownload = null;
            //   }
            //   imageDownload = null;
            //
            //   print(imageDownload);
            // }
            // progress: ,
          ),
          Positioned(
            right: 80,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade200,
                size: 40,
              ),
              onPressed: () {
                fileImage = null;
                deleteImage(urlImage);
                Navigator.pop(context);
                notifyListeners();
              },
            ),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  imageProfile(context) {
    pickImage(context);

  }

  deleteImage(String pImageurl) async {
    StorageReference reference = await storage.getReferenceFromUrl(pImageurl);
    await reference.delete();
  }

  updateUrlImage(context, String deleteImageUrl) async {
    notifyListeners();
    try {
      StorageReference ref = storage.ref().child(Path.basename(fileImage.path));
      StorageUploadTask uploadTask = ref.putFile(fileImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      final urlStor = await taskSnapshot.ref.getDownloadURL();
      print(urlStor);

      updateImageUrl = urlStor;

      StorageReference reference =
          await storage.getReferenceFromUrl(deleteImageUrl);
      reference.delete();
      print('updateImageUrl' + updateImageUrl);
      print('deleteImageUrl' + deleteImageUrl);
    } catch (ex) {
      print(ex);
    }
  }
}

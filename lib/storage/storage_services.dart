// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';

// import 'dart:io' as io;

// class StorageServices extends ChangeNotifier {
//   Future<UploadTask?> uploadFile(PickedFile? file) async {
//     if (file == null) return null;
//     UploadTask uploadTask;
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child("/product_images")
//         .child(DateTime.now().toString() + '.jpg');
//     final metadata = SettableMetadata(
//       contentType: 'image/jpeg',
//       customMetadata: {'picked-file-path': file.path},
//     );

//     if (kIsWeb)
//       uploadTask = ref.putData(await file.readAsBytes(), metadata);
//     else
//       uploadTask = ref.putFile(io.File(file.path), metadata);

//     return Future.value(uploadTask);
//   }
// }

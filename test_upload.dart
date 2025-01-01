import 'package:firebase_core/firebase_core.dart';
import 'package:blogify_flutter/services/firebase_storage_service.dart';

void main() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Create an instance of FirebaseStorageService
  FirebaseStorageService storageService = FirebaseStorageService();

  // Define the file path and name
  String filePath = 'test_upload.txt'; // Relative path to the test file
  String fileName = 'test_upload.txt';

  // Upload the file
  try {
    String downloadURL = await storageService.uploadFile(filePath, fileName);
    print('File uploaded successfully! Download URL: $downloadURL');
  } catch (e) {
    print('Error: $e');
  }
}

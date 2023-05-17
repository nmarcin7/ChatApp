import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore get db => _db;

  void sendMessage(String message) async {
    await _db.collection('messages').add(
      {
        'sender': user!.email,
        'message': message,
        'date': DateTime.now(),
      },
    );
  }
}

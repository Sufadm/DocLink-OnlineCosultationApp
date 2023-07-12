import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  void addMessage(String text, String uid, DateTime time) {
    DocumentReference userProfileRef =
        FirebaseFirestore.instance.collection('userprofile').doc(uid);

    CollectionReference messagesCollectionRef =
        userProfileRef.collection('messages');

    messagesCollectionRef.add({
      'text': text,
      'uid': uid,
      'time': time,
    });
  }

  Stream<QuerySnapshot> getMessages() {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userProfileRef =
        FirebaseFirestore.instance.collection('userprofile').doc(currentUserId);

    CollectionReference messagesCollectionRef =
        userProfileRef.collection('messages');

    return messagesCollectionRef.orderBy('time', descending: false).snapshots();
  }

  // Stream<QuerySnapshot> getMessages() {
  //   final collection = FirebaseFirestore.instance.collection('messages');
  //   return collection.orderBy('time', descending: false).snapshots();
  // }
}
  // void addMessage(String text, String uid, DateTime time) {
  //   FirebaseFirestore.instance.collection('messages').add({
  //     'text': text,
  //     'uid': uid,
  //     'time': time,
  //   });
  // }
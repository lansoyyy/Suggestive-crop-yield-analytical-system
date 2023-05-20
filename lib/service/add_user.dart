import 'package:cloud_firestore/cloud_firestore.dart';

Future addUser(name, address, username) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc();

  final json = {
    'name': name,
    'address': address,
    'username': username,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}

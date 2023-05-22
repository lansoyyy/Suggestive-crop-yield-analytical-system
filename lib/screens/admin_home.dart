import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_analytical_system/utils/colors.dart';
import 'package:crop_analytical_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'auth/login_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: TextRegular(
          text: 'Admin Home',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: TextBold(
                            text: 'Logout Confirmation',
                            color: Colors.black,
                            fontSize: 14),
                        content: TextRegular(
                            text: 'Are you sure you want to logout?',
                            color: Colors.black,
                            fontSize: 16),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: TextBold(
                                text: 'Close',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: TextBold(
                                text: 'Continue',
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ],
                      ));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 48,
                    ),
                    trailing: const Icon(
                      Icons.arrow_right_sharp,
                    ),
                    title: TextBold(
                      text: data.docs[index]['name'],
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    subtitle: TextRegular(
                      text: data.docs[index]['address'],
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

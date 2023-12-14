import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/text_widget.dart';

class ContactusScreen extends StatelessWidget {
  const ContactusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(
          text: 'Contact Us',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextRegular(
                color: Colors.black,
                text: 'Contact Details',
                fontSize: 24,
              ),
              const Divider(),
              TextRegular(
                color: Colors.black,
                text: 'Email: cropanalytical@gmail.com',
                fontSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),
              TextRegular(
                color: Colors.black,
                text: 'Phone Number: 09639530422',
                fontSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),
              TextRegular(
                color: Colors.black,
                text: 'Facebook Page: facebook.com/cropanalytical',
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

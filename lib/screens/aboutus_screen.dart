import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/text_widget.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(
          text: 'About Us',
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
                text: 'About Us',
                fontSize: 32,
              ),
              const Divider(),
              TextRegular(
                color: Colors.black,
                text:
                    'Irure in enim sit velit adipisicing labore ut. Officia nulla adipisicing amet et ullamco anim voluptate nostrud culpa ullamco adipisicing proident. Consequat excepteur sunt aute do laboris voluptate labore aliquip dolor ea ea cillum deserunt culpa. ',
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crop_analytical_system/screens/auth/signup_screen.dart';
import 'package:crop_analytical_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  final box = GetStorage();
  late String email = '';

  late String password = '';
  late String adminPassword = '';

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/veges.png',
              fit: BoxFit.cover,
            ),
            TextBold(
                text: 'Crop ', fontSize: 42, color: const Color(0xff4E7B02)),
            TextBold(
                text: 'Analytical System',
                fontSize: 42,
                color: const Color(0xff4E7B02)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.bottomLeft,
                child:
                    TextBold(text: 'Login', fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                    onChanged: ((value) {
                      email = value;
                    }),
                    decoration: const InputDecoration(
                        prefixText: '',
                        border: InputBorder.none,
                        hintText: '    Username',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'QRegular',
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                    onChanged: ((value) {
                      password = value;
                    }),
                    decoration: const InputDecoration(
                        prefixText: '',
                        border: InputBorder.none,
                        hintText: '    Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'QRegular',
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 150,
                  child: ButtonWidget(
                      onPressed: (() {
                        if (box.read('email') != email ||
                            box.read('password') != password) {
                          Fluttertoast.showToast(msg: 'Invalid Account!');
                        } else {
                          Fluttertoast.showToast(msg: 'Logged in!');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      }),
                      label: 'Login'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextRegular(
                    text: 'No Account?', fontSize: 12, color: Colors.grey),
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    }),
                    child: TextBold(
                        text: 'Create now', fontSize: 14, color: Colors.black))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: (() {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => RegisterScreen()));
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: TextBold(
                              text: 'Enter admin password',
                              fontSize: 14,
                              color: Colors.black),
                          content: SizedBox(
                            width: 100,
                            height: 40,
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Admin password',
                                suffixIcon: Icon(Icons.lock),
                              ),
                              onChanged: ((value) {
                                adminPassword = value;
                              }),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: (() {
                                if (adminPassword != 'admin123') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: TextRegular(
                                          text: 'Invalid Password',
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } else {
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const AdminHome()));
                                }
                              }),
                              child: TextBold(
                                  text: 'Continue',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ],
                        );
                      }));
                }),
                child: TextBold(
                    text: 'Signup as Admin', fontSize: 14, color: primary)),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

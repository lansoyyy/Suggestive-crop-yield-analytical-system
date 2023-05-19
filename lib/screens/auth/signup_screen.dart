import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import 'login_page.dart';

class RegisterScreen extends StatelessWidget {
  final box = GetStorage();
  late String email = '';

  late String password = '';
  late String confirmPassword = '';

  RegisterScreen({super.key});
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
            Stack(
              children: [
                Image.asset(
                  'assets/images/veges.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
            TextBold(
                text: 'Vegetables',
                fontSize: 42,
                color: const Color(0xff4E7B02)),
            TextBold(
                text: 'Scanner', fontSize: 42, color: const Color(0xff4E7B02)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.bottomLeft,
                child:
                    TextBold(text: 'Signup', fontSize: 18, color: Colors.black),
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
                        hintText: '    Email',
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
                    obscureText: true,
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
                    obscureText: true,
                    onChanged: ((value) {
                      confirmPassword = value;
                    }),
                    decoration: const InputDecoration(
                        prefixText: '',
                        border: InputBorder.none,
                        hintText: '    Confirm Password',
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
                        if (email.contains('@')) {
                          if (confirmPassword != password) {
                            Fluttertoast.showToast(
                                msg: 'Password do not match!');
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Account created succesfully!');
                            box.write('email', email);
                            box.write('password', password);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please provide a valid email address!');
                        }
                      }),
                      label: 'Signup'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

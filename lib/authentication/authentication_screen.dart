import 'package:admin_web/main_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPass = "";

  allowAdminToLogin() async {
    SnackBar snackBar = SnackBar(
      content: Text(
        'Checking Credentials, Please wait',
        style: TextStyle(fontSize: 36, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: adminEmail,
          password: adminPass,
        )
        .then((fAuth) => currentAdmin = fAuth.user)
        .catchError((onError) {
      final snackBar = SnackBar(
        content: Text(
          'Error Occured' + onError.toString(),
          style: TextStyle(fontSize: 36, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null) {
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          print('Document found, navigating to HomeScreen...');
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        } else {
          print('No record found');
          SnackBar snackBar = SnackBar(
            content: Text(
              'No Record Found',
              style: TextStyle(fontSize: 36, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }).catchError((error) {
        print('Error: $error');
      });
    }



    // if (currentAdmin != null) {
    //   await FirebaseFirestore.instance
    //       .collection("admins")
    //       .doc(currentAdmin!.uid)
    //       .get()
    //       .then((snap) {
    //     if (snap.exists) {
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (c) => const HomeScreen()));
    //     }
    //     else
    //       {
    //         SnackBar snackBar = SnackBar(
    //           content: Text(
    //             'No Record Found',
    //             style: TextStyle(fontSize: 36, color: Colors.black),
    //           ),
    //           backgroundColor: Colors.white,
    //           duration: Duration(seconds: 5),
    //         );
    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //       }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/FS.jpg"),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      adminEmail = value;
                    },
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Admin Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      adminPass = value;
                    },
                    obscureText: true,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Admin Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(Icons.admin_panel_settings,
                            color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        allowAdminToLogin();
                      },
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.cyan),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.pinkAccent),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 16),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

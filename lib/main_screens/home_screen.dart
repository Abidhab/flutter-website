import 'package:admin_web/authentication/authentication_screen.dart';
import 'package:admin_web/main_screens/surveyListPage.dart';
import 'package:admin_web/main_screens/survey_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _projectName = new TextEditingController();
  TextEditingController _clientName = new TextEditingController();
  TextEditingController _eventName = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff57BAC0),
        title: Text(
          'Welcome to Admin Web Portal',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>SurveyListPage() ),);},
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsetsDirectional.symmetric(
                            horizontal: 150, vertical: 25)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Surveys',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsetsDirectional.symmetric(
                            horizontal: 150, vertical: 25)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Empty Surveys',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _projectName,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Project Name ",
                          hintStyle: TextStyle(color: Colors.grey),
                          constraints: BoxConstraints(maxWidth: 500),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _clientName,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Client Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          constraints: BoxConstraints(maxWidth: 500),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2))),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller:_eventName ,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Event Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          constraints: BoxConstraints(maxWidth: 500),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2))),
                    ),
                  ],
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SurveyPage(projectName: '${_projectName.text}', clientName: '${_clientName.text}', eventName: '${_eventName.text}',),));
                    },
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(100),
                          ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      'Creat New Surveys',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      )

      // Row(mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //   ElevatedButton(onPressed: (){
      //     FirebaseAuth.instance.signOut();
      //     Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
      //   }, child: Text("LOG OUT"))
      // ],)
      ,
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {


  bool isHiddenPass=true;

  bool isconfirmpass=true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confpasscontroller = TextEditingController();

  void CreatAccount() async {
    String email = emailcontroller.text.trim();
    String Password = passwordcontroller.text.trim();
    String confirmpassword = confpasscontroller.text.trim();

    if (email == "" || Password == "" || confirmpassword == "") {
      log("please fill the details!");
    } else if (Password != confirmpassword) {
      log("password do not match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: Password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Create an Account")),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Email",
                  hintText: "Enter Email"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(obscureText: isHiddenPass,
              controller: passwordcontroller,
              decoration: InputDecoration(

                suffixIcon: InkWell(
                  onTap: togglepassword,
                  
                  child: Icon(Icons.visibility)),
                  border: OutlineInputBorder(),
                  labelText: "Enter Password",
                  hintText: "Enter Password"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: confpasscontroller,
              decoration: InputDecoration(

                suffixIcon: InkWell(
                  onTap: toggleconfirmpass,
                  
                  child: Icon(Icons.visibility)),
                  border: OutlineInputBorder(),
                  labelText: "confirm Password",
                  hintText: "confirm Password"),obscureText: isconfirmpass,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                CreatAccount();
              },
              child: Text("Create Account"))
        ],
      ),
    );
  }

   void togglepassword(){
    if (isHiddenPass==true){
      isHiddenPass=false;
    }else{
      isHiddenPass=true;
      
    }
    setState(() {
      
    });



  
}
   void toggleconfirmpass(){
    if (isconfirmpass==true){
      isconfirmpass=false;
    }else{
      isconfirmpass=true;
      
    }
    setState(() {
      
    });
}
}
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_556/Screen1.dart';
import 'package:flutter_556/screens/email_auth/signupscreen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  bool isHiddenPass=true;
  
   TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> login () async {
     String email = emailcontroller.text.trim();
    String Password = passwordcontroller.text.trim();

    if (email==""|| Password==""){
      log("please fill the details");
    }
    else{
try{ UserCredential userCredential= await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: Password);
if (userCredential.user!=""){

  Navigator.popUntil(context, (route) => route.isFirst);

  
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen1(),));
}

}on FirebaseAuthException catch (ex){
  log(ex.code.toString());
}

 


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("LOG IN")),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: emailcontroller,
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
            child: TextField(controller: passwordcontroller,
              decoration: InputDecoration(
                
                suffixIcon: InkWell(onTap: togglepassword,
                  
                  child: Icon(Icons.visibility)),
                  border: OutlineInputBorder(),
                  labelText: "Enter Password",
                  hintText: "Enter Password"),obscureText: isHiddenPass,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {
            login();
          }, child: Text("LOG IN")),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              child: Text("Create an Account"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signupscreen(),
                    ));
              }),
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
}

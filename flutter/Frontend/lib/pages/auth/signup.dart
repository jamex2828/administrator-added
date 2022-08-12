import 'package:Login/pages/borrower_page.dart';
import 'package:flutter/material.dart';
import 'package:Login/api/user/register.dart';
import 'package:Login/main.dart';
import 'package:Login/pages/auth/admin_login.dart';

//Basically the Login Page Contains a form That is not the best form since main focus was on Logic
//Yes I copied the above comment from Login 😊

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //This is to store FormState don't know anything about it but its important🙂
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //These Variables Store Form Data
  String? _username, _email, _password, _confirmPassword, _usertype;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //gradient colors of orange
              Color(0xfffd5800),
              Color(0xccfd5800),
              Color(0x99fd5800),
              Color(0xB3fd5800),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(30),
              ),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Email is required';
                        }
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Username is required';
                        }
                      },
                      onChanged: (value) {
                        _username = value;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                          labelText: "Usertype: admin, student, personel"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Usertype is required';
                        }
                      },
                      onChanged: (value) {
                        _usertype = value;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(labelText: "Password"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Password is required';
                        }
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration:
                          const InputDecoration(labelText: "Confirm Password"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value != _password) {
                          return 'Password not same';
                        }
                      },
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MaterialApp(
                                            home: AdminLoginPage(),
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xfffd5800),
                            ),
                            child: const Text("Login page")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (!_formkey.currentState!.validate()) {
                                return;
                              }
                              print(_username);
                              RegisterUser('${_username}', '${_email}',
                                      '${_password}', '${_usertype}')
                                  .then(((value) {
                                if (value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const MaterialApp(
                                                  home: BorrowerPage())),
                                      (route) => false);
                                }
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xfffd5800),
                            ),
                            child: const Text("Sign Up")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

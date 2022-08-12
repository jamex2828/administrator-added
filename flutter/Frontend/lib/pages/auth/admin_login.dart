import 'package:Login/pages/borrower_page.dart';
import 'package:flutter/material.dart';
import 'package:Login/api/user/admin_login.dart';
import 'package:Login/main.dart';
import 'package:Login/pages/auth/signup.dart';
import 'package:Login/pages/auth/admin_login.dart';

//Basically the Login Page Contains a form That is not the best form since main focus was on Logic

class AdminLoginPage extends StatefulWidget {
  AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? _username, _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("CL1M INVENTORY"),
            backgroundColor: const Color(0xfffd5800),
          ),
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
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(30),
                  ),
                  const Text(
                    'Sign In',
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
                          decoration:
                              const InputDecoration(labelText: 'Username'),
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
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Password is required';
                            }
                          },
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MaterialApp(
                                      home: Signup(),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xfffd5800),
                              ),
                              child: const Text('Register Admin'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!_formkey.currentState!.validate()) {
                                  return;
                                }
                                (_username);
                                adminLogin('${_username}', '${_password}').then(
                                  ((value) {
                                    if (value) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const MaterialApp(
                                              home: BorrowerPage(),
                                            ),
                                          ),
                                          (route) => false);
                                    }
                                  }),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xfffd5800),
                              ),
                              child: const Text("Log in"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

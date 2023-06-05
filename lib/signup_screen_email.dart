import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenEmailSignUp extends StatefulWidget {
  const ScreenEmailSignUp({Key? key}) : super(key: key);

  @override
  State<ScreenEmailSignUp> createState() => _ScreenEmailSignUpState();
}

class _ScreenEmailSignUpState extends State<ScreenEmailSignUp> {
  var firebaseAuth = FirebaseAuth.instance;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email signup"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: passwordController,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () {
                      try {
                        String email = emailController.text.toString();
                        String password = passwordController.text.toString();

                        firebaseAuth
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((UserCredential user_credential) {
                          print("ob ${user_credential.user.toString()}");
                          print(
                              "ob ${user_credential.credential!.signInMethod}");
                          print("ob ${user_credential.credential!.token}");
                        }).onError((FirebaseAuthException error, stackTrace) {
                          if (error.code == "email-already-in-use") {
                            print(
                                "object this email is already in use by some other account");
                          }
                        });
                      } catch (e) {
                        print("object error ${e.toString()}");
                      }
                    },
                    child: Text(
                      "Sign up with email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () {
                      try {
                        String email = emailController.text.toString();
                        String password = passwordController.text.toString();

                        firebaseAuth
                            .signInWithEmailAndPassword(
                                email: email, password: password)
                            .then((UserCredential user_credential) {
                          print("ob ${user_credential.user.toString()}");
                          print(
                              "ob ${user_credential.credential!.signInMethod}");
                          print("ob ${user_credential.credential!.token}");
                        }).onError((FirebaseAuthException error, stackTrace) {
                          if (error.code ==
                              "The password is invalid or the user does not have a password.") {
                            print(
                                "object this is a wrong password. please re-try with correct one");
                          }
                        });
                      } catch (e) {
                        print("object error ${e.toString()}");
                      }
                    },
                    child: Text(
                      "Sign in with email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {
                      try {
                        firebaseAuth.signInAnonymously().then((value) {
                          print(
                              "object ${firebaseAuth.currentUser.toString()}");
                        }).onError((FirebaseAuthException error, stackTrace) {
                          if (error.code == "email-already-in-use") {
                            print(
                                "object this email is already in use by some other account");
                          }
                        });
                      } catch (e) {
                        print("object error ${e.toString()}");
                      }
                    },
                    child: Text(
                      "Anonymouse",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {
                      try {
                        firebaseAuth.signOut().then((value) {
                          print("The user has been signed out");
                        });
                      } catch (e) {
                        print("object error ${e.toString()}");
                      }
                    },
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {
                      try {

                          print("${firebaseAuth.currentUser.toString()}");

                      } catch (e) {
                        print("object error ${e.toString()}");
                      }
                    },
                    child: Text(
                      "Current user",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

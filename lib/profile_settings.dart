import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slow_your_roll/sign_up_screen.dart';
import 'package:slow_your_roll/slow_your_roll_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dismiss_text_button.dart';
import 'styles.dart';


class ProfileSettings extends StatelessWidget {

  final SlowYourRollUser currentUser;

  const ProfileSettings({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body: DarkBackgroundContainer(
          child: ListView(
            children: [
              TextButton(
                child: const Text('Change Profile Image'),
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery).catchError((error) {
                    print(error);
                  });
                  print(image);
                  print(image?.path);
                  if (image != null) {
                    final File file = File(image.path);
                    final storageRef = FirebaseStorage.instance.ref('users/${currentUser.uid}');
                    storageRef.putFile(file).then((success) async {
                      print(success.bytesTransferred);
                      print(success);
                      final downloadUrl = await success.ref.getDownloadURL();
                      print(downloadUrl);
                      currentUser.updateUserProfileImageLocation(downloadUrl);
                    }).catchError((error) {
                      print(error);
                    });
                  }
                },
              ),
              const Divider(
                color: Colors.white54,
              ),
              TextButton(
                child: const Text('Contact the Support Team'),
                onPressed: () async {
                  final mail = Uri(scheme: 'mailto', path: 'support@undauntedathlete.com', query: 'subject=Slow%20Your%20Roll%20Support&body=Hi Slow Your Roll Support Team,\n\nI\'m having the following issue with the app...');
                  if (!await launchUrl(mail)) throw 'Could not launch mail';
                },
              ),
              const Divider(
                color: Colors.white54,
              ),
              TextButton(
                child: const Text('Delete Account',
                style: TextStyle(
                  color: Colors.red,
                ),),
                onPressed: () {

                  TextEditingController passwordController = TextEditingController();

                  showDialog(context: context, barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure you want to delete your account?',
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Please re-enter your password and all of your account data will be deleted from our databases.'),
                              const SizedBox(
                                height: 6.0,
                              ),
                              TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2c3e50),
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2c3e50),
                                      )
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF2c3e50),
                                        width: 2.0,
                                      )
                                  ),
                                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel',
                                style: TextStyle(
                                  color: const Color(0xFF2c3e50),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                onPrimary: Colors.white,
                              ),
                              child: Text('Delete Account',
                                style: TextStyle(
                                  //color: Color(0xFF2c3e50),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                                ),
                              ),
                              onPressed: () {
                                final password = passwordController.text;
                                FirebaseAuth.instance.signInWithEmailAndPassword(email: currentUser.email!, password: password).then((value) async {
                                  final uid = FirebaseAuth.instance.currentUser?.uid;

                                  //Navigator.of(context).popUntil(ModalRoute.withName('SignUpScreen'));

                                //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen(deleteUser: true,))).then((value) {

                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                    print("navigating complete. now deleting");
                                    FirebaseFirestore.instance.collection('users').doc(uid).delete().then((_) {
                                      //TODO: Show pop up for delete success.
                                      FirebaseAuth.instance.currentUser?.delete().then((_) => print("success")).catchError((error){
                                        print("error deleting");
                                        print(error);
                                      });
                                    }).catchError((error) {
                                      //TODO: Handle error
                                      print("error deleting document");
                                      print(error);
                                    });
                                  }).catchError((error){
                                    final FirebaseAuthException exception = error;
                                    final message = exception.message ?? 'Unknown password error. Please try again.';
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Error Confirming Password'),
                                        content: Text(message),
                                        actions: const [
                                          DismissTextButton()
                                        ],
                                      );
                                    });
                                  });

                              },
                            )
                          ],
                        );
                      });


                },
              ),
              const Divider(
                color: Colors.white54,
              ),
              TextButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((_) {
                    //Successful sign out.
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));
                  })
                      .catchError((error){
                    //Error signing out.
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text('Sign out could not be completed.'),
                        content: Text('$error. If this error continues please contact support.'),
                        actions: const [
                          DismissTextButton()
                        ],
                      );
                    });
                  });

                },
              ),
              const Divider(
                color: Colors.white54,
              ),
            ],
          ),
        ));
  }
}

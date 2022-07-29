import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:slow_your_roll/dismiss_text_button.dart';
import 'package:slow_your_roll/styles.dart';

import 'main_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  attemptSignIn() async {
    context.loaderOverlay.show();
    //Attempt firebase sign in. Figure out how to handle error.
    FocusScope.of(context).unfocus();
    final email = _emailController.text;
    final password = _passwordController.text;

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((userCredential) {
      //Sign in success.
      context.loaderOverlay.hide();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScaffold()));
    })
        .catchError((error) {
      //If Sign in Error

      context.loaderOverlay.hide();
      final FirebaseAuthException exception = error;
      final message = exception.message;

      showDialog(context: context, barrierDismissible: false, builder: (context) {
        return AlertDialog(
          title: const Text('Error Signing In',
          ),
          content: Text('$message Please try again.'),
          actions: const [
            DismissTextButton()
          ],
        );
      });
    });


  }

  showForgotPasswordDialog() {
    TextEditingController _forgotPasswordEmailController = TextEditingController();

    showDialog(context: context, barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Your Email to Reset Your Password',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter your email to receive instructions as to how to reset your password.'),
                const SizedBox(
                  height: 6.0,
                ),
                TextField(
                  controller: _forgotPasswordEmailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
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
                  primary: const Color(0xFF2c3e50),
                  onPrimary: Colors.white,
                ),
                child: Text('Reset Password',
                  style: TextStyle(
                    //color: Color(0xFF2c3e50),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    fontFamily: GoogleFonts.redHatDisplay().fontFamily,
                  ),
                ),
                onPressed: () {
                  final email = _forgotPasswordEmailController.text;
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email)
                      .then((value) {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title:  const Text('Reset Password Email Sent'),
                        content:  const Text('Please follow the instructions in your email to reset your password.'),
                        actions: [
                          TextButton(
                            child: const Text('OK',
                              style: TextStyle(
                                  color: Color(0xFF2c3e50),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                  })
                      .catchError((error) {
                    final FirebaseAuthException exception = error;
                    final message = exception.message ?? 'Unknown password reset error. Please try again.';
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text('Error Resetting Password'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(child: CircularProgressIndicator(
          color: Colors.yellow.withAlpha(200),
        )),
        child: DarkBackgroundContainer(
            height: double.infinity,
            width: double.infinity,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Image.asset('images/slowyourroll-logo.png',
                      height: 100.0,
                      // width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Text('Slow Your Roll',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,),
                    Text('Mental Performance Training',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,),
                    Text(
                      'with Greg Graber',
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                      ),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 16.0,
                      ),
                      onEditingComplete: () => _passwordFocusNode.requestFocus(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      autocorrect: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 16.0,
                      ),
                      onEditingComplete: () => attemptSignIn(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      child: Text('Sign In'),
                      onPressed: () => attemptSignIn(),
                    ),
                    TextButton(
                      child: Text('Forgot Password'),
                      onPressed: () => showForgotPasswordDialog(),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}

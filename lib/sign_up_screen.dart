import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slow_your_roll/create_account_screen.dart';
import 'login_screen.dart';
import 'styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DarkBackgroundContainer(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Image.asset('images/greg-nobg.png',
                  // width: MediaQuery.of(context).size.width * 0.8,
                ),
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
                textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Mental performance coach who has worked with The Memphis Grizzlies, LSU Men\'s Basketball, Marquette Men\'s Basketball, TCU Men\'s Basketball, VCU Men\'s Basketball, Siena Men\'s Basketball, Rice Men\'s Basketball, McNeese Men\'s Basketball, George Washington Men\'s Basketball, and many more, along with executives and other top competitors.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OutlinedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(settings: const RouteSettings(name: 'SignUpScreen'), builder: (context) => const CreateAccountScreen()));
                }, child: const Text('Create Account'),
                  style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all(Size.fromHeight(40.0)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ))
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Text('Already have an account?',
                style: Theme.of(context).textTheme.bodyText2,),
              TextButton(
                child: const Text('Sign In'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(settings: const RouteSettings(name: 'SignUpScreen'), builder: (context) => const LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slow_your_roll/dismiss_text_button.dart';
import 'package:slow_your_roll/main_scaffold.dart';
import 'package:slow_your_roll/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timezone/timezone.dart' as tz;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  String? passwordError;
  String? confirmPasswordError;
  Icon? passwordSuccessIcon;
  Icon? confirmPasswordSuccessIcon;

  attemptCreateAccount() async {
    //Attempt firebase sign in. Figure out how to handle error.
    context.loaderOverlay.show();
    FocusScope.of(context).unfocus();

    final email = _emailController.text;
    final password = _passwordController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;

    if (_passwordController.text == _confirmPasswordController.text) {
      //Passwords match, create account.
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) async {
        //Successful user creation
        final newUser = userCredential.user!;
        newUser.sendEmailVerification();
        newUser.updateDisplayName('$firstName $lastName');
        final uid = newUser.uid;
        final db = FirebaseFirestore.instance;
        final List<String> emptyListString = [];
        final Map<String, bool> completedAudios = {
          'intro': false,
          'mentalPerformance': false,
          'thoughtsEmotions': false,
          'stayingPresent': false,
          'dealingStress': false,
          'listeningBody': false,
          'beforePracticeGames': false,
          'presentCompetition': false,
          'breatheSucceed': false,
          'mentalReset': false,
          'mettaKindness': false,
          'affirmations': false,
          'meditation': false,
          'visualization': false,
          'gratitude': false,
          'sleep': false,
          'moreTips': false,
        };

        final today = tz.TZDateTime.now(tz.local);
        final subScriptionDate = today.add(const Duration(days: 5));
        final formatter = DateFormat('yyyy-MM-dd');
        final formattedSubDate = formatter.format(subScriptionDate);


        await db.collection('users').doc(uid).set({
          'email' : email,
          'firstName': firstName,
          'lastName': lastName,
          'streak': 0,
          'bestStreak': 0,
          'activity': emptyListString,
          'totalMinutes': 0,
          'subscriptionDate': formattedSubDate,
          'profileImageURL': null,
          'completedAudios': completedAudios,
          'lastMeditation': 0,
          'lastAffirmation': 0,
        }).catchError((error) {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text('Could not create user in database.'),
              content: Text('Please contact support with a screenshot of this error. $error'),
              actions: const [
                DismissTextButton()
              ],
            );
          });
        });

        context.loaderOverlay.hide();
        showDialog(context: context, barrierDismissible: false, builder: (context) {
          return AlertDialog(
            title: const Text('Account Created!'),
            content: Text('Welcome, $firstName $lastName! We offer a five day free trial of the Slow Your Roll app so you can explore all it has to offer. If you\'d like to continue using Slow Your Roll after the free trial, please purchase a one year subscription.'),
            actions: [
              TextButton(
                child: const Text('OK',
                  style: TextStyle(
                      color: Color(0xFF2c3e50),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(maintainState: false, builder: (context) => const MainScaffold()));
                },
              )
            ],
          );
        });
      }).catchError((error){

        final FirebaseAuthException exception = error;
        final message = exception.message ?? 'Please try again.';
        context.loaderOverlay.hide();
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Error creating account.'),
            content: Text(message),
            actions: const [
              DismissTextButton()
            ],
          );
        });
      });

    } else {
      //TODO: //Passwords do not match. Show Error.
      context.loaderOverlay.hide();
      showDialog(context: context, barrierDismissible: false, builder: (context){
        return AlertDialog(
          title: const Text('Passwords do not match.'),
          content: const Text('Please make sure the password and confirm password fields are identical and try again.'),
          actions: [
            TextButton(
              child: const Text('OK',
                style: TextStyle(
                    color: Color(0xFF2c3e50),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
    }


    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScaffold()));
  }

  onPasswordChanged(String userInput) {
    setState(() {
      if (userInput.length < 6) {
        passwordError = 'Password must be at least six characters long.';
        passwordSuccessIcon = null;
      } else {
        passwordError = null;
        passwordSuccessIcon = const Icon(Icons.check_circle, color: Color(0xFF4DBD98),);
      }
    });
  }

  onConfirmPasswordChanged(String userInput) {
    setState(() {
      if (userInput != _passwordController.text) {
        confirmPasswordError = 'Passwords do not match';
        confirmPasswordSuccessIcon = null;
      } else {
        confirmPasswordError = null;
        confirmPasswordSuccessIcon = const Icon(Icons.check_circle, color: Color(0xFF4DBD98),);
      }
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
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            focusNode: _firstNameFocusNode,
                            autocorrect: false,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                            ),
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 16.0,
                            ),
                            onEditingComplete: () => _passwordFocusNode.requestFocus(),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            focusNode: _lastNameFocusNode,
                            autocorrect: false,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                            ),
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 16.0,
                            ),
                            onEditingComplete: () => _passwordFocusNode.requestFocus(),
                          ),
                        )
                      ],
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
                      textInputAction: TextInputAction.next,
                      onChanged: (userInput) => onPasswordChanged(userInput),
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: passwordError,
                        suffixIcon: passwordSuccessIcon,
                      ),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 16.0,
                      ),
                      onEditingComplete: () => _confirmPasswordFocusNode.requestFocus(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      autocorrect: false,
                      obscureText: true,
                      onChanged: (userInput) => onConfirmPasswordChanged(userInput),
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        errorText: confirmPasswordError,
                        suffixIcon: confirmPasswordSuccessIcon,
                      ),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 16.0,
                      ),
                      onEditingComplete: () => attemptCreateAccount(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () => attemptCreateAccount(),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text('Signing up for an account is free and allows you to explore content within the app.',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

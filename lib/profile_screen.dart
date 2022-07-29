import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slow_your_roll/profile_settings.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'package:slow_your_roll/slow_your_roll_user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userSnapshotProvider);
    return userStream.when(data: (value) {
      final uid = value!.id;
      final currentUser = SlowYourRollUser.fromSnapshot(uid, value);
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSettings(currentUser: currentUser)));
                },
              ),
            ),
          ],
        ),
        body: DarkBackgroundContainer(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFdedede), width: 2.0),
                          // image: const DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image: AssetImage('assets/hoop.jpg',),
                          // )
                        ),
                        height: 80,
                        width: 80,
                        child: currentUser.userCircleAvatar,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('${currentUser.firstName}\'s Stats',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Meditation Streak',
                                style: GoogleFonts.redHatDisplay(),),
                              Text('${currentUser.streak}',
                                style: Theme.of(context).textTheme.headline2,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text('Past Seven Days',),
                              Text(currentUser.pastSevenDayActivity,
                                style: Theme.of(context).textTheme.headline2,),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Meditation Minutes'),
                              Text('${currentUser.totalMinutes}',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text('Past Thirty Days',),
                              Text(currentUser.pastThirtyDaysActivity,
                                style: Theme.of(context).textTheme.headline2,),
                            ],
                          ),
                        ),
                      ],),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text('Subscription Info',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('Your subscription expires on ${currentUser.subscriptionDateAsLongString}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16.0
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                      child: const Text('Purchase Subscription'),
                      onPressed: () {
                        currentUser.addToSubscription();
                      },

                    ),
                    Text('A yearly subscription gives you access to the content greg uses with his NCAA Men\'s Division 1 Clients and the daily exercises he recommends along with immediate access to any new releases of content.',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Divider(
                      height: 1.0,
                      color: Colors.white54,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text('About Your Coach Greg Graber',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset('images/greg-nobg.png',
                        // width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Mental performance coach who has worked with The Memphis Grizzlies, LSU Men\'s Basketball, Marquette Men\'s Basketball, TCU Men\'s Basketball, VCU Men\'s Basketball, Siena Men\'s Basketball, Rice Men\'s Basketball, McNeese Men\'s Basketball, George Washington Men\'s Basketball, and many more, along with executives and other top competitors.',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          //fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,),
                    ),
                    const SizedBox(height: 12.0),
                    Text('To book a speaking engagement, request more information on having Greg work with your team, or schedule an individual consultation:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),),
                    // ElevatedButton(
                    //   child: const Text('Schedule an Individual Consultation'),
                    //   onPressed: () => print('individual'),
                    // ),
                    // ElevatedButton(
                    //   child: const Text('Book a Speaking Engagement'),
                    //   onPressed: () => print('speaking'),
                    // ),
                    ElevatedButton(
                      child: const Text('Contact Greg'),
                      onPressed: () async {
                        final mail = Uri(scheme: 'mailto', path: 'info@greggraber.com', query: 'subject=Inquiry via Slow Your Roll App&body=Hi Greg,\n\nI found you on the Slow Your Roll app and I\'m reaching out because...',);
                        if (!await launchUrl(mail)) throw 'Could not launch mail';
                      },
                    ),
                  ],
                )

            )
        ),
      );
    },
        error: (_, __) => const RiverpodError(screenName: 'Profile Screen'),
        loading: () => const RiverpodLoading());
  }
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DarkBackgroundContainer(
//         height: double.infinity,
//         width: double.infinity,
//         child: SafeArea(
//             child: ListView(
//               padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
//               children: [
//                 Center(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       //borderRadius: BorderRadius.circular(20.0),
//                       border: Border.all(color: const Color(0xFFdedede), width: 2.0),
//                       // image: const DecorationImage(
//                       //   fit: BoxFit.cover,
//                       //   image: AssetImage('assets/hoop.jpg',),
//                       // )
//                     ),
//                     height: 80,
//                     width: 80,
//                     child: const CircleAvatar(
//                       radius: 40.0,
//                       backgroundImage: AssetImage('images/greg.png',),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Text('Greg\'s Stats',
//                   style: Theme.of(context).textTheme.headline2,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Meditation Streak',
//                             style: GoogleFonts.redHatDisplay(),),
//                           Text('5',
//                             style: Theme.of(context).textTheme.headline2,
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(
//                             height: 8.0,
//                           ),
//                           const Text('Past Seven Days',),
//                           Text('6 of 7  -  86%',
//                             style: Theme.of(context).textTheme.headline2,),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text('Meditation Minutes'),
//                           Text('270',
//                             style: Theme.of(context).textTheme.headline2,
//                           ),
//                           const SizedBox(
//                             height: 8.0,
//                           ),
//                           const Text('Past Thirty Days',),
//                           Text('27 of 30  -  90%',
//                             style: Theme.of(context).textTheme.headline2,),
//                         ],
//                       ),
//                     ),
//                   ],),
//                 const SizedBox(
//                   height: 24.0,
//                 ),
//                 Text('Subscription Info',
//                   style: Theme.of(context).textTheme.headline3,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Text('Your subscription expires on April 17, 2023',
//                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                       fontSize: 16.0
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 ElevatedButton(
//                   onPressed: () => print("purchase sub"),
//                   child: Text('Purchase Subscription'),
//                 ),
//                 Text('A yearly subscription gives you access to the content greg uses with his NCAA Men\'s Division 1 Clients and the daily exercises he recommends along with immediate access to any new releases of content.',
//                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 24.0,
//                 ),
//                 TextButton(
//                   child: const Text('Sign Out'),
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut().then((_) {
//                       //Successful sign out.
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));
//                     })
//                         .catchError((error){
//                       //Error signing out.
//                       showDialog(context: context, builder: (context) {
//                         return AlertDialog(
//                           title: Text('Sign out could not be completed.'),
//                           content: Text('$error. If this error continues please contact support.'),
//                           actions: const [
//                             DismissTextButton()
//                           ],
//                         );
//                       });
//                     });
//
//                   },
//                 ),
//                 const SizedBox(
//                   height: 24.0,
//                 ),
//                 const Divider(
//                   height: 1.0,
//                   color: Colors.white54,
//                 ),
//                 const SizedBox(
//                   height: 24.0,
//                 ),
//                 Text('About Your Coach Greg Graber',
//                   style: Theme.of(context).textTheme.headline3,
//                 ),
//                 SizedBox(
//                   height: 300,
//                   width: double.infinity,
//                   child: Image.asset('images/greg-nobg.png',
//                     // width: MediaQuery.of(context).size.width * 0.8,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Text('Mental performance coach who has worked with The Memphis Grizzlies, LSU Men\'s Basketball, Marquette Men\'s Basketball, TCU Men\'s Basketball, VCU Men\'s Basketball, Siena Men\'s Basketball, Rice Men\'s Basketball, McNeese Men\'s Basketball, George Washington Men\'s Basketball, and many more, along with executives and other top competitors.',
//                     style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                       //fontStyle: FontStyle.italic,
//                     ),
//                     textAlign: TextAlign.left,),
//                 ),
//                 ElevatedButton(
//                   child: const Text('Schedule an Individual Consultation'),
//                   onPressed: () => print('individual'),
//                 ),
//                 ElevatedButton(
//                   child: const Text('Book a Speaking Engagement'),
//                   onPressed: () => print('speaking'),
//                 ),
//                 ElevatedButton(
//                   child: const Text('Contact Greg'),
//                   onPressed: () => print('contact'),
//                 ),
//               ],
//             )
//
//         )
//     );
//   }
// }

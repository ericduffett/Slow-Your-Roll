import 'package:flutter/material.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'audio_content.dart';
import 'content_card.dart';
import 'slow_your_roll_user.dart';
import 'styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//TODO: Move this list of AudioContent into the user as a const so that we can use algorithm to show recommended next content.
//We may need to save the user's last completed audio so that they have a suggestion on what to do next.
//Ask whether game day or practice?

class ContentScreenConsumer extends ConsumerWidget {
  const ContentScreenConsumer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userSnapshotProvider);
    return userStream.when(data: (value) {
      final uid = value!.id;
      print(uid);
      final currentUser = SlowYourRollUser.fromSnapshot(uid, value);
      return DarkBackgroundContainer(
          height: double.infinity,
          width: double.infinity,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                  children: [
                    Text('Slow Your Roll Course',
                      style: Theme.of(context).textTheme.headline3,),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['intro']!
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['mentalPerformance']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['thoughtsEmotions']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['stayingPresent']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['dealingStress']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['listeningBody']!
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['beforePracticeGames']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['presentCompetition']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['breatheSucceed']!
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['mentalReset']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['mettaKindness']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['affirmations']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['mantras']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['meditation']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['visualization']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['gratitude']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['sleep']!,
                    ),
                    ContentCard(
                      audioContent: currentUser.userAudioContentList['moreTips']!,
                    ),

                  ]),
            ),
          )
      );
    },
        error: (_, __) => const RiverpodError(screenName: 'Content Screen'),
        loading: () => const RiverpodLoading());
  }
}

// class ContentScreen extends StatefulWidget {
//   const ContentScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ContentScreen> createState() => _ContentScreenState();
// }
//
// class _ContentScreenState extends State<ContentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DarkBackgroundContainer(
//         height: double.infinity,
//         width: double.infinity,
//         child: SafeArea(
//           bottom: false,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ListView(
//                 children: [
//                   Text('Slow Your Roll Course',
//                     style: Theme.of(context).textTheme.headline3,),
//                   ContentCard(
//                     audioContent: AudioContent(
//                       title: 'Introduction',
//                       description: 'Welcome to Slow Your Roll',
//                       minutes: 12,
//                       imagePath: 'images/march-madness.jpeg',
//                       completed: true,
//                     ),
//                   ),
//                   ContentCard(
//                     audioContent: AudioContent(
//                       title: 'Mental Performance',
//                       description: 'And why it\'s important',
//                       minutes: 9,
//                       imagePath: 'images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg',
//                       completed: true,
//                     ),
//                   ),
//                   ContentCard(
//                     audioContent: AudioContent(
//                       title: 'Dealing with Thoughts & Emotions',
//                       description: 'How to handle the ups and downs',
//                       minutes: 14,
//                       imagePath: 'images/hakii-official-mLpay96vBSw-unsplash.jpeg',
//                     ),
//                   ),
//                   ContentCard(
//                     audioContent: AudioContent(
//                       title: 'Staying Present',
//                       description: 'Tips on how to be in the moment',
//                       minutes: 7,
//                       imagePath: 'images/hyunwon-jang-95ZtqUyCxvU-unsplash.jpeg',
//                     ),
//                   ),
//                   Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     elevation: 3.0,
//                     clipBehavior: Clip.antiAlias,
//                     shape: const RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.black38,
//                           width: 2.0,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
//                         decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                               // stops: [
//                               //   0.8,
//                               //   1.0,
//                               //   ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 //  transform: GradientRotation(0.8),
//                                 colors: [
//                                   // Color(0xFF2a2a72), Dark Blue
//                                   // Color(0xFF009ffd), Ocean Blue
//                                   //Color(0xFFffffff), //White
//                                   //Color(0xFFe4e6eb), //Offwhite
//                                   Color(0xFF0c67a8),
//                                   Color(0xFF049edb)
//                                 ]
//                             )
//                         ),
//                         height: 150,
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Introduction',
//                               style: Theme.of(context).textTheme.headline2,
//                               textAlign: TextAlign.center,),
//                             Text('Learn more about Slow Your Roll',
//                               style: Theme.of(context).textTheme.headline5,),
//                             const SizedBox(
//                               height: 12.0,
//                             ),
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Text('PLAY LESSON',
//                                   style: TextStyle(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.bold,
//                                     //color: Color(0xFF2c3e50),
//                                     color: Colors.white,
//                                   ),),
//                                 // SizedBox(
//                                 //   width: 8.0,
//                                 // ),
//                                 // Icon(Icons.play_circle_outline,
//                                 //   size: 16.0,)
//                               ],
//                             )
//                           ],
//                         )),
//                   ),
//                   Card(
//                     margin: EdgeInsets.zero,
//                     clipBehavior: Clip.antiAlias,
//                     shape: const RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.white10,
//                           width: 3.0,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     child: SizedBox(
//                       // color: Theme.of(context).canvasColor,
//                       height: 150,
//                       width: double.infinity,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: Material(
//                           elevation: 4.0,
//                           child: Ink.image(
//                             image: AssetImage('images/tan-kuen-yuen-cXXuAUCTihQ-unsplash.jpeg'),
//                             colorFilter:
//                             ColorFilter.mode(Colors.black38, BlendMode.darken),
//                             fit: BoxFit.cover,
//                             width: 120,
//                             child: InkWell(
//                               child: Center(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('Introduction',
//                                       style: Theme.of(context).textTheme.headline2,
//                                       textAlign: TextAlign.center,),
//                                     Text('Learn more about Slow Your Roll',
//                                       style: Theme.of(context).textTheme.headline5!.copyWith(
//                                         color: Colors.white,
//                                       ),),
//                                     const SizedBox(
//                                       height: 12.0,
//                                     ),
//                                     const Icon(Icons.play_circle_outline,
//                                       color: Colors.white,
//                                       size: 36.0,),
//                                     // const Text('PLAY LESSON',
//                                     //   style: TextStyle(
//                                     //     fontSize: 14.0,
//                                     //     fontWeight: FontWeight.bold,
//                                     //     color: Colors.white,
//                                     //   ),),
//                                   ],
//                                 ),
//                               ),
//                               onTap: () => print("tap"),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Card(
//                     margin: const EdgeInsets.symmetric(vertical: 6.0),
//                     clipBehavior: Clip.antiAlias,
//                     shape: const RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.white10,
//                           width: 3.0,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     child: SizedBox(
//                       height: 150,
//                       width: double.infinity,
//                       child: Stack(
//                         children: [
//                           Container(
//                             foregroundDecoration: const BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                   colors: [
//                                     Colors.black87,
//                                     Colors.black54,
//                                     Colors.black12
//                                   ],
//                                   stops: [
//                                     0.3,
//                                     0.6,
//                                     1.0
//                                   ],
//                                 )
//                             ),
//                             height: double.infinity,
//                             width: double.infinity,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     alignment: Alignment.center,
//                                     image: AssetImage('images/tan-kuen-yuen-cXXuAUCTihQ-unsplash.jpeg')
//                                 )
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('Introduction',
//                                   style: Theme.of(context).textTheme.headline2,
//                                   textAlign: TextAlign.left,),
//                                 Text('Learn more about Slow Your Roll',
//                                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                                     color: Colors.white,
//                                   ),),
//                               ],
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 16.0),
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Icon(Icons.play_circle_outline_rounded,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 )
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Card(
//                     margin: const EdgeInsets.symmetric(vertical: 6.0),
//                     clipBehavior: Clip.antiAlias,
//                     shape: const RoundedRectangleBorder(
//                         side: BorderSide(
//                           color: Colors.white10,
//                           width: 3.0,
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     child: SizedBox(
//                       height: 150,
//                       width: double.infinity,
//                       child: Stack(
//                         children: [
//                           Container(
//                             foregroundDecoration: const BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                   colors: [
//                                     Colors.black87,
//                                     Colors.black54,
//                                     Colors.black12
//                                   ],
//                                   stops: [
//                                     0.3,
//                                     0.6,
//                                     1.0
//                                   ],
//                                 )
//                             ),
//                             height: double.infinity,
//                             width: double.infinity,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     alignment: Alignment.topRight,
//                                     image: AssetImage('images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg')
//                                 )
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('Mental Performance',
//                                   style: Theme.of(context).textTheme.headline2,
//                                   textAlign: TextAlign.left,),
//                                 Text('and why it\'s important',
//                                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                                     color: Colors.white,
//                                   ),),
//                               ],
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 8.0),
//                             child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Icon(Icons.double_arrow,
//                                   color: Colors.white,
//                                   size: 24.0,
//                                 )
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Text('5 Minutes',
//                                   textAlign: TextAlign.center,
//                                   style: Theme.of(context).textTheme.headline2!.copyWith(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w900,
//                                   )),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0, right: 8.0),
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(width: 3, color: Colors.white54)),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ]),
//           ),
//         )
//     );
//   }
// }

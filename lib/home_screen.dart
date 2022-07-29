import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'package:slow_your_roll/slow_your_roll_user.dart';
import 'mini_card.dart';
import 'audio_content.dart';
import 'content_card.dart';
import 'styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomeScreen extends StatelessWidget {
//
//   final SlowYourRollUser currentUser;
//
//   const HomeScreen({Key? key, required this.currentUser}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DarkBackgroundContainer(
//       height: double.infinity,
//       width: double.infinity,
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Hello, ${currentUser.firstName}',
//                     style: Theme.of(context).textTheme.headline3!.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18.0,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       //borderRadius: BorderRadius.circular(20.0),
//                       border: Border.all(color: const Color(0xFFdedede), width: 2.0),
//                       // image: const DecorationImage(
//                       //   fit: BoxFit.cover,
//                       //   image: AssetImage('assets/hoop.jpg',),
//                       // )
//                     ),
//                     height: 36,
//                     width: 36,
//                     child: const CircleAvatar(
//                       radius: 18.0,
//                       backgroundImage: AssetImage('images/greg.png',),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 8.0,
//               ),
//               Text('Next Lesson',
//                 style: Theme.of(context).textTheme.headline3,),
//               ContentCard(
//                 audioContent: AudioContent(
//                     title: 'Mental Performance',
//                     description: 'And why it\'s important',
//                     minutes: 12,
//                     imagePath: 'images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg',
//                     audioPath: 'gs://slowyourroll-f50b3.appspot.com/audio/testaudio1.m4a'
//                 ),
//               ),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               Text('Daily Exercises',
//                 style: Theme.of(context).textTheme.headline3,),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: MiniCard(
//                       audioContent: AudioContent(
//                           title: 'Meditation',
//                           description: '',
//                           minutes: 10,
//                           imagePath: 'images/hyunwon-jang-95ZtqUyCxvU-unsplash.jpeg',
//                           audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
//                           completed: currentUser.hasCompletedMeditationToday
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8.0,
//                   ),
//                   Expanded(
//                     child: MiniCard(
//                       audioContent: AudioContent(
//                         title: 'Affirmation',
//                         description: '',
//                         minutes: 8,
//                         imagePath: 'images/hakii-official-mLpay96vBSw-unsplash.jpeg',
//                         audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
//                         completed: currentUser.hasCompletedAffirmationToday,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               Text('Your Stats',
//                 style: Theme.of(context).textTheme.headline3,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Meditation Streak',
//                           style: GoogleFonts.redHatDisplay(),),
//                         Text('${currentUser.streak}',
//                           style: Theme.of(context).textTheme.headline2,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(
//                           height: 8.0,
//                         ),
//                         const Text('Past Seven Days',),
//                         Text(currentUser.pastSevenDayActivity,
//                           style: Theme.of(context).textTheme.headline2,),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Meditation Minutes'),
//                         Text('${currentUser.totalMinutes}',
//                           style: Theme.of(context).textTheme.headline2,
//                         ),
//                         const SizedBox(
//                           height: 8.0,
//                         ),
//                         const Text('Past Thirty Days',),
//                         Text(currentUser.pastThirtyDaysActivity,
//                           style: Theme.of(context).textTheme.headline2,),
//                       ],
//                     ),
//                   ),
//                 ],),
//             ],
//
//           ),
//         ),
//       ),
//     );
//   }
// }


class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userSnapshotProvider);
    return userStream.when(
        data: (value) {
          final uid = value!.id;
          final currentUser = SlowYourRollUser.fromSnapshot(uid, value);
          return DarkBackgroundContainer(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hello, ${currentUser.firstName}',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: const Color(0xFFdedede), width: 2.0),
                            // image: const DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: AssetImage('assets/hoop.jpg',),
                            // )
                          ),
                          height: 36,
                          width: 36,
                          child: currentUser.userCircleAvatar,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text('Next Lesson',
                      style: Theme.of(context).textTheme.headline3,),
                    ContentCard(
                      audioContent: currentUser.recommendedAudio,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text('Daily Exercises',
                      style: Theme.of(context).textTheme.headline3,),

                    Row(
                      children: [
                        Expanded(
                          child: MiniCard(
                            audioContent: AudioContent(
                                title: 'Meditation',
                                description: '',
                                minutes: 10,
                                imagePath: 'images/hyunwon-jang-95ZtqUyCxvU-unsplash.jpeg',
                                audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
                                keyName: 'meditation',
                                lessonNumber: 99,
                                completed: currentUser.hasCompletedMeditationToday
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: MiniCard(
                            audioContent: AudioContent(
                              title: 'Affirmation',
                              description: '',
                              minutes: 8,
                              imagePath: 'images/humberto-pena-xYLESttJzUI-unsplash.jpeg',
                              audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
                              keyName: 'affirmations',
                              lessonNumber: 99,
                              completed: currentUser.hasCompletedAffirmationToday,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text('Your Stats',
                      style: Theme.of(context).textTheme.headline3,),
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
                  ],

                ),
              ),
            ),
          );
        },
        error: (_, __) => const RiverpodError(screenName: 'Home Screen'),
        loading: () => const RiverpodLoading()
    );
  }
}


//Removed once we added in Riverpod

//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DarkBackgroundContainer(
//       height: double.infinity,
//       width: double.infinity,
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               // Text('Hello, Greg',
//               // textAlign: TextAlign.center,
//               //     style: Theme.of(context).textTheme.headline2,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   HomeScreenConsumerAgain(),
//                   // Text('Hello, Greg',
//                   //     style: Theme.of(context).textTheme.headline3!.copyWith(
//                   //       fontWeight: FontWeight.w600,
//                   //       fontSize: 18.0,
//                   //     ),
//                   // ),
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       //borderRadius: BorderRadius.circular(20.0),
//                       border: Border.all(color: const Color(0xFFdedede), width: 2.0),
//                       // image: const DecorationImage(
//                       //   fit: BoxFit.cover,
//                       //   image: AssetImage('assets/hoop.jpg',),
//                       // )
//                     ),
//                     height: 36,
//                     width: 36,
//                     child: const CircleAvatar(
//                       radius: 18.0,
//                       backgroundImage: AssetImage('images/greg.png',),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 8.0,
//               ),
//               Text('Next Lesson',
//                 style: Theme.of(context).textTheme.headline3,),
//               ContentCard(
//                 audioContent: AudioContent(
//                     title: 'Mental Performance',
//                     description: 'And why it\'s important',
//                     minutes: 12,
//                     imagePath: 'images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg'
//                 ),
//               ),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               Text('Daily Exercises',
//                 style: Theme.of(context).textTheme.headline3,),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: MiniCard(
//                       audioContent: AudioContent(
//                           title: 'Meditation',
//                           description: 'None needed',
//                           minutes: 10,
//                           imagePath: 'images/hyunwon-jang-95ZtqUyCxvU-unsplash.jpeg'
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8.0,
//                   ),
//                   Expanded(
//                     child: MiniCard(
//                       audioContent: AudioContent(
//                           title: 'Affirmation',
//                           description: 'None needed',
//                           minutes: 8,
//                           imagePath: 'images/hakii-official-mLpay96vBSw-unsplash.jpeg'
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               Text('Your Stats',
//                 style: Theme.of(context).textTheme.headline3,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Meditation Streak',
//                           style: GoogleFonts.redHatDisplay(),),
//                         Text('5',
//                           style: Theme.of(context).textTheme.headline2,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(
//                           height: 8.0,
//                         ),
//                         const Text('Past Seven Days',),
//                         Text('6 of 7  -  86%',
//                           style: Theme.of(context).textTheme.headline2,),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Meditation Minutes'),
//                         Text('270',
//                           style: Theme.of(context).textTheme.headline2,
//                         ),
//                         const SizedBox(
//                           height: 8.0,
//                         ),
//                         const Text('Past Thirty Days',),
//                         Text('27 of 30  -  90%',
//                           style: Theme.of(context).textTheme.headline2,),
//                       ],
//                     ),
//                   ),
//                 ],),
//             ],
//
//           ),
//         ),
//       ),
//     );
//   }
// }

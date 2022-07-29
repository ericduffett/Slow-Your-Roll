import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

import 'audio_content.dart';

final firebaseAuthProvider =
Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// 2
final authStateChangesProvider = StreamProvider<User?>(
        (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final userSnapshotProvider = StreamProvider<DocumentSnapshot?>((ref) {

  final auth = ref.watch(authStateChangesProvider);

  if (auth.asData?.value?.uid != null) {
    final uid = auth.asData!.value!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  } else {
    return const Stream.empty();
  }
});


class SlowYourRollUser {
  String? uid;
  String? email;
  String firstName;
  String lastName;
  int streak;
  int bestStreak;
  List<dynamic> activity;
  int totalMinutes;
  String subscriptionDate;
  String? profileImageURL;
  Map<String, bool> completedAudios;
  int lastMeditation; //Milliseconds since epoch
  int lastAffirmation; //Milliseconds since epoch


  SlowYourRollUser({
    this.uid,
    this.email,
    this.firstName = 'New',
    this.lastName = 'User',
    this.streak = 0,
    this.bestStreak = 0,
    this.activity = const [],
    this.totalMinutes = 0,
    this.subscriptionDate = '2019-07-10',
    this.profileImageURL,
    this.completedAudios = const {
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
    },
    this.lastMeditation = 0,
    this.lastAffirmation = 0,
  });

  factory SlowYourRollUser.fromSnapshot(String uid, DocumentSnapshot snapshot) {

    return SlowYourRollUser(
      uid: uid,
      email: snapshot.get('email'),
      firstName: snapshot.get('firstName'),
      lastName: snapshot.get('lastName'),
      streak: snapshot.get('streak'),
      bestStreak: snapshot.get('bestStreak'),
      activity: snapshot.get('activity'),
      totalMinutes: snapshot.get('totalMinutes'),
      subscriptionDate: snapshot.get('subscriptionDate'),
      profileImageURL: snapshot.get('profileImageURL'),
      completedAudios: snapshot.get('completedAudios').cast<String, bool>(),
      lastMeditation: snapshot.get('lastMeditation'),
      lastAffirmation: snapshot.get('lastAffirmation'),
    );
  }

  Map<String, AudioContent> get userAudioContentList {
    return {
      'intro': AudioContent(
        title: 'Introduction',
        description: 'Welcome to Slow Your Roll',
        minutes: 12,
        imagePath: 'images/march-madness.jpeg',
        keyName: 'intro',
        lessonNumber: 0,
        completed: completedAudios['intro'] ?? false,
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
      ),
      'mentalPerformance' : AudioContent(
          title: 'Mental Performance',
          description: 'And why it\'s important',
          minutes: 9,
          imagePath: 'images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg',
          keyName: 'mentalPerformance',
          lessonNumber: 1,
          completed: completedAudios['mentalPerformance'] ?? false,
          audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe'
      ),
      'thoughtsEmotions' : AudioContent(
        title: 'Dealing with Thoughts & Emotions',
        description: 'How to handle the ups and downs',
        minutes: 14,
        imagePath: 'images/hakii-official-mLpay96vBSw-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'thoughtsEmotions',
        lessonNumber: 2,
        completed: completedAudios['thoughtsEmotions'] ?? false,
      ),
      'stayingPresent' : AudioContent(
        title: 'Staying Present',
        description: 'Tips on how to be in the moment',
        minutes: 7,
        imagePath: 'images/jared-murray-gu2ajoA2ShY-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'stayingPresent',
        lessonNumber: 3,
        completed: completedAudios['stayingPresent'] ?? false,
      ),
      'dealingStress' : AudioContent(
        title: 'Dealing with Stress',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/qi-xna-Ii7adwWwNh4-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'dealingStress',
        lessonNumber: 4,
        completed: completedAudios['dealingStress'] ?? false,
      ),
      'listeningBody' : AudioContent(
        title: 'Listening to Your Body',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/eduard-delputte-YLmCyMofG6s-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'listeningBody',
        lessonNumber: 5,
        completed: completedAudios['listeningBody'] ?? false,
      ),
      'beforePracticeGames' : AudioContent(
        title: 'What to do Before Practice and Games',
        description: 'Description for Greg to create',
        minutes: 12,
        imagePath: 'images/hadis-abedini-pUxth57W0M4-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'beforePracticeGames',
        lessonNumber: 6,
        completed: completedAudios['beforePracticeGames'] ?? false,
      ),
      'presentCompetition' : AudioContent(
        title: 'Staying Present During Competition',
        description: 'Description for Greg to create',
        minutes: 10,
        imagePath: 'images/sid-suratia-rCh34CtvhqI-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'presentCompetition',
        lessonNumber: 7,
        completed: completedAudios['presentCompetition'] ?? false,
      ),
      'breatheSucceed' : AudioContent(
        title: 'Breathe to Succeed',
        description: 'Description for Greg to create',
        minutes: 6,
        imagePath: 'images/tom-pottiger-fz92ybo3N0M-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'breatheSucceed',
        lessonNumber: 8,
        completed: completedAudios['breatheSucceed'] ?? false,
      ),
      'mentalReset' : AudioContent(
        title: 'Mental Resets',
        description: 'Description for Greg to create',
        minutes: 5,
        imagePath: 'images/ben-eaton-pcd3ibWJKsM-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'mentalReset',
        lessonNumber: 9,
        completed: completedAudios['mentalReset'] ?? false,
      ),
      'mettaKindness' : AudioContent(
        title: 'Metta-Loving Kindness',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/noah-fuentes-3gmngQ7_XMw-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'mettaKindness',
        lessonNumber: 10,
        completed: completedAudios['mettaKindness'] ?? false,
      ),
      'affirmations' : AudioContent(
        title: 'Affirmations',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/humberto-pena-xYLESttJzUI-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'affirmations',
        lessonNumber: 11,
        completed: completedAudios['affirmations'] ?? false,
      ),
      'mantras' : AudioContent(
        title: 'Mantras',
        description: 'Description for Greg to create',
        minutes: 4,
        imagePath: 'images/tom-briskey-Jpex9Y_sZOE-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'mantras',
        lessonNumber: 12,
        completed: completedAudios['mantras'] ?? false,
      ),
      'meditation' : AudioContent(
        title: 'Meditation',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/hyunwon-jang-95ZtqUyCxvU-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'meditation',
        lessonNumber: 13,
        completed: completedAudios['meditation'] ?? false,
      ),
      'visualization' : AudioContent(
        title: 'Visualization',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/leo-foureaux-2AKSYXynUCo-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'visualization',
        lessonNumber: 14,
        completed: completedAudios['visualization'] ?? false,
      ),
      'gratitude' : AudioContent(
        title: 'Gratitude',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/andrew-seaman-BZper8HE-wQ-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'gratitude',
        lessonNumber: 15,
        completed: completedAudios['gratitude'] ?? false,
      ),
      'sleep' : AudioContent(
        title: 'Sleep',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/josip-ivankovic-EGsc2Y5KfYE-unsplash.jpeg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'sleep',
        lessonNumber: 16,
        completed: completedAudios['sleep'] ?? false,
      ),
      'moreTips' : AudioContent(
        title: 'More Tips to Build Your Focus',
        description: 'Description for Greg to create',
        minutes: 7,
        imagePath: 'images/sas-kia-r5tFWRUbIJ4-unsplash.jpg',
        audioPath: 'https://firebasestorage.googleapis.com/v0/b/slowyourroll-f50b3.appspot.com/o/audio%2Ftestaudio1.m4a?alt=media&token=f4db92ff-ebf4-4ee0-ae97-4e3a364bb8fe',
        keyName: 'moreTips',
        lessonNumber: 17,
        completed: completedAudios['moreTips'] ?? false,
      ),

    };
  }

  AudioContent get recommendedAudio {

    AudioContent audioToRecommend = userAudioContentList['moreTips']!;

    for (var k in userAudioContentList.keys) {
      AudioContent checkAudio = userAudioContentList[k]!;
      if (!checkAudio.completed && (checkAudio.lessonNumber < audioToRecommend.lessonNumber)) {
        audioToRecommend = checkAudio;
      }
    }

    //Generate random recommendation if all lessons have been completed.
    if (audioToRecommend.keyName == 'moreTips' && userAudioContentList['moreTips']!.completed) {
      final randomLessonNumber = Random().nextInt(18);
      for (var k in userAudioContentList.keys) {
        AudioContent checkAudio = userAudioContentList[k]!;
        if (checkAudio.lessonNumber == randomLessonNumber) {
          audioToRecommend = checkAudio;
        }
      }
    }

    return audioToRecommend;
  }

  bool get hasActiveSubscription {
    final now = tz.TZDateTime.now(tz.local);
    final subAsDate = tz.TZDateTime.parse(tz.local, subscriptionDate);
    if (subAsDate.isAfter(now)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addToSubscription() async {
    final currentSubscriptionString = subscriptionDate;
    final currentSubscriptionDate = tz.TZDateTime.parse(tz.local, currentSubscriptionString);
    final newSubscriptionDate = currentSubscriptionDate.add(const Duration(days: 365));
    final dateFormat = DateFormat('yyyy-MM-dd');
    final newSubscriptionString = dateFormat.format(newSubscriptionDate);
    //TODO: Save to Firebase.
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'subscriptionDate': newSubscriptionString,
    });

  }

  String get subscriptionDateAsLongString {
    final formatter = DateFormat.yMMMMd('en_US');
    final subAsDate = tz.TZDateTime.parse(tz.local, subscriptionDate);
    return formatter.format(subAsDate);
  }

  bool get hasActivityToday {
    final now = tz.TZDateTime.now(tz.local);
    if (activity.isNotEmpty) {
      final lastActivity = activity[0] as int;
      final activityDate = tz.TZDateTime.fromMillisecondsSinceEpoch(
          tz.local, lastActivity);

      if (now.year == activityDate.year && now.month == activityDate.month &&
          now.day == activityDate.day) {
        return true;
      } else {
        return false;
      }
    } else { //Actvity is empty.
      return false;
    }
  }

  Future<void> saveUserActivity(String keyName) async {

    Map<String, dynamic> mapToInsert = {}; //Using single map to batch write
    final bool hasCompletedAudio = completedAudios[keyName] ?? false;

    if (!hasCompletedAudio) {
      completedAudios[keyName] = true;
      mapToInsert['completedAudios'] = completedAudios;
    }

    if (!hasActivityToday) {
      final currentTime = tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
      final activityCopy = activity.map((e) => e).toList();
      activityCopy.insert(0, currentTime);
      mapToInsert['activity'] = activityCopy;
    }


    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(uid).update(mapToInsert);
  }

  Future<void> addToMeditationStreak() async {
    if (!hasCompletedMeditationToday) {
      totalMinutes += 10;
      streak += 1;
      lastMeditation = tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
      final db = FirebaseFirestore.instance;
      await db.collection('users').doc(uid).update({
        'lastMeditation': lastMeditation,
        'streak': streak,
        'totalMinutes': totalMinutes,
      });
    }
  }

  Future<void> recordAffirmation() async {
      lastAffirmation = tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
      final db = FirebaseFirestore.instance;
      await db.collection('users').doc(uid).update({
        'lastAffirmation': lastAffirmation,
      });
  }

  Future<void> updateUserProfileImageLocation(String newLocation) async {
    profileImageURL = newLocation;
    final db = FirebaseFirestore.instance;
    await db.collection('users').doc(uid).update({
      'profileImageURL': profileImageURL,
    });
  }

  ImageProvider get userProfileImage {
    if (profileImageURL != null) {
      return NetworkImage(profileImageURL!);
    }

    return const AssetImage('images/slowyourroll-logo.png');
  }

  Widget get userCircleAvatar {

    if (profileImageURL != null) {
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 18.0,
        backgroundImage: userProfileImage,
      );
    } else {
      String firstInitial = '';
      String lastInitial = '';
      if (firstName.isNotEmpty) {
        firstInitial = firstName[0].toUpperCase();
      }

      if (lastName.isNotEmpty) {
        lastInitial = lastName[0].toUpperCase();
      }

      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 18.0,
        child: Text('$firstInitial$lastInitial',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF2c3e50),
        ),),
      );
    }

  }


  bool get hasCompletedMeditationToday {
    final now = tz.TZDateTime.now(tz.local);
    final meditationDate = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, lastMeditation);

    if (now.year == meditationDate.year && now.month == meditationDate.month && now.day == meditationDate.day) {
      return true;
    } else {
      return false;
    }
  }

  bool get hasCompletedAffirmationToday {
    final now = tz.TZDateTime.now(tz.local);
    final meditationDate = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, lastAffirmation);

    if (now.year == meditationDate.year && now.month == meditationDate.month && now.day == meditationDate.day) {
      return true;
    } else {
      return false;
    }
  }


  //TODO: These two activity indicators are expecting the latest activity to be inserted at 0 as milliseconds since epoch and without repeating an entry on the same day.

  String get pastSevenDayActivity {
    int activeDays = 0;
    if (activity.isNotEmpty) {
      final now = tz.TZDateTime.now(tz.local);
      final startOfDayNow = DateTime(now.year, now.month, now.day);
      for (int i = 0; (i < 7 && i < activity.length); i++) {
        final activityMilliseconds = activity[i];
        final date = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, activityMilliseconds);
        final startOfDate = DateTime(date.year, date.month, date.day);
        if (startOfDayNow.difference(startOfDate).inDays < 7) {
          ++activeDays;
        }
      }
    }



    final percentFormat = NumberFormat.percentPattern();
    percentFormat.maximumFractionDigits = 0;

    final activityPercentage = activeDays.toDouble() / 7.0;
    final roundedPercentage = percentFormat.format(activityPercentage);

    return '$activeDays of 7 - $roundedPercentage';
  }

  String get pastThirtyDaysActivity {

    int activeDays = 0;
    int offset = 0;
    if (activity.isNotEmpty) {
      final now = tz.TZDateTime.now(tz.local);
      final startOfDayNow = DateTime(now.year, now.month, now.day);
      final mostRecentActivity = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, activity[0]);
      final startOfDayMostRecentActivity = DateTime(mostRecentActivity.year, mostRecentActivity.month, mostRecentActivity.day);
      offset = startOfDayNow.difference(startOfDayMostRecentActivity).inDays;
      for (int i = 0; (i < 30 && i < activity.length && i < 30 - offset); i++) {
        // final now = tz.TZDateTime.now(tz.local).subtract(Duration(days: offset));
        // final comparisonDate = now.subtract(Duration(days: i));
        final activityMilliseconds = activity[i];
        final date = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, activityMilliseconds);
        final startOfDate = DateTime(date.year, date.month, date.day);
        if (startOfDayNow.difference(startOfDate).inDays < 30) {
          ++activeDays;
        }
        // if (comparisonDate.year == date.year && comparisonDate.month == date.month && comparisonDate.day == date.day) {
        //   ++activeDays;
        // }
      }
    }

    final percentFormat = NumberFormat.percentPattern();
    percentFormat.maximumFractionDigits = 0;

    final activityPercentage = activeDays.toDouble() / 30.0;
    final roundedPercentage = percentFormat.format(activityPercentage);

    return '$activeDays of 30 - $roundedPercentage';
  }


}
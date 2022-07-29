
class AudioContent {
  final String title;
  final String description;
  final int minutes;
  final String imagePath;
  final String audioPath;
  final String keyName; //Matches key in map stored in firebase to determined whether it's been completed.
  final int lessonNumber;
  bool completed;
  AudioContent({required this.title, required this.description, required this.minutes, required this.imagePath, required this.audioPath, required this.keyName, required this.lessonNumber, this.completed = false});
}
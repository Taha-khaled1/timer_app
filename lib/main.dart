import 'package:task_manger/presentation_layer/screen/succss_screen.dart';
import 'package:task_manger/presentation_layer/screen/task_screen/task_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:task_manger/application_layer/app/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manger/presentation_layer/notification_service/notification_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
// import 'package:background_music/database.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  tz.initializeTimeZones();
  await Firebase.initializeApp();

  DateTime firstDateTime = DateTime.now();
  const String _keyPrefix = 'user_activity_';
  final formattedDate =
      "${firstDateTime.year}-${firstDateTime.month}-${firstDateTime.day}";
  final key = '$_keyPrefix$formattedDate';
  if (sharedPreferences.getInt(key) == null) {
    sharedPreferences.setInt(key, 0);
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

@pragma("vm:entry-point")
void overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("lev") == null) {
    sharedPreferences.setString("lev", '0');
  }
  tz.initializeTimeZones();
  await Firebase.initializeApp();

  DateTime firstDateTime = DateTime.now();
  const String _keyPrefix = 'user_activity_';
  final formattedDate =
      "${firstDateTime.year}-${firstDateTime.month}-${firstDateTime.day}";
  final key = '$_keyPrefix$formattedDate';
  if (sharedPreferences.getInt(key) == null) {
    sharedPreferences.setInt(key, 0);
  }
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskOverlay(),
    ),
  );
}
// MediaItem mediaItem = MediaItem(
//     id: songList[0].url,
//     title: songList[0].name,
//     artUri: Uri.parse(songList[0].icon),
//     album: songList[0].album,
//     duration: songList[0].duration,
//     artist: songList[0].artist);

// int current = 0;

// _backgroundTaskEntrypoint() {
//   AudioServiceBackground.run(() => AudioPlayerTask());
// }

// class AudioPlayerTask extends BaseAudioHandler with SeekHandler {
//   final _audioPlayer = AudioPlayer();

//   @override
//   Future<void> onStart(Map<String, dynamic> params) async {
//     AudioServiceBackground.setState(controls: [
//       MediaControl.pause,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seekTo
//     ], playing: true, processingState: AudioProcessingState.connecting);
//     // Connect to the URL
//     await _audioPlayer.setUrl(mediaItem.id);
//     AudioServiceBackground.setMediaItem(mediaItem);
//     // Now we're ready to play
//     _audioPlayer.play();
//     // Broadcast that we're playing, and what controls are available.
//     AudioServiceBackground.setState(controls: [
//       MediaControl.pause,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seekTo
//     ], playing: true, processingState: AudioProcessingState.ready);
//   }

//   @override
//   Future<void> onStop() async {
//     AudioServiceBackground.setState(
//         controls: [],
//         playing: false,
//         processingState: AudioProcessingState.ready);
//     await _audioPlayer.stop();
//     await super.onStop();
//   }

//   @override
//   Future<void> onPlay() async {
//     AudioServiceBackground.setState(controls: [
//       MediaControl.pause,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seekTo
//     ], playing: true, processingState: AudioProcessingState.ready);
//     await _audioPlayer.play();
//     return super.onPlay();
//   }

//   @override
//   Future<void> onPause() async {
//     AudioServiceBackground.setState(controls: [
//       MediaControl.play,
//       MediaControl.stop,
//       MediaControl.skipToNext,
//       MediaControl.skipToPrevious
//     ], systemActions: [
//       MediaAction.seekTo
//     ], playing: false, processingState: AudioProcessingState.ready);
//     await _audioPlayer.pause();
//     return super.onPause();
//   }

//   @override
//   Future<void> onSkipToNext() async {
//     if (current < songList.length - 1)
//       current = current + 1;
//     else
//       current = 0;
//     mediaItem = MediaItem(
//         id: songList[current].url,
//         title: songList[current].name,
//         artUri: Uri.parse(songList[current].icon),
//         album: songList[current].album,
//         duration: songList[current].duration,
//         artist: songList[current].artist);
//     AudioServiceBackground.setMediaItem(mediaItem);
//     await _audioPlayer.setUrl(mediaItem.id);
//     AudioServiceBackground.setState(position: Duration.zero);
//     return super.onSkipToNext();
//   }

//   @override
//   Future<void> onSkipToPrevious() async {
//     if (current != 0)
//       current = current - 1;
//     else
//       current = songList.length - 1;
//     mediaItem = MediaItem(
//         id: songList[current].url,
//         title: songList[current].name,
//         artUri: Uri.parse(songList[current].icon),
//         album: songList[current].album,
//         duration: songList[current].duration,
//         artist: songList[current].artist);
//     AudioServiceBackground.setMediaItem(mediaItem);
//     await _audioPlayer.setUrl(mediaItem.id);
//     AudioServiceBackground.setState(position: Duration.zero);
//     return super.onSkipToPrevious();
//   }

//   @override
//   Future<void> onSeekTo(Duration position) {
//     _audioPlayer.seek(position);
//     AudioServiceBackground.setState(position: position);
//     return super.onSeekTo(position);
//   }
// }

// // ---------------------------------------------------------------------------------- ----------------------- ---------------- ---------------------- -----------
// class Song {
//   final String url;
//   final String name;
//   final String artist;
//   final String icon;
//   final String album;
//   final Duration duration;
//   Song({
//     required this.url,
//     required this.name,
//     required this.artist,
//     required this.icon,
//     required this.album,
//     required this.duration,
//   });
// }

// List<Song> songList = [
//   Song(
//       url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
//       name: "Song 1",
//       artist: "Artist 1",
//       duration: Duration(minutes: 6, seconds: 12),
//       icon:
//           "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg",
//       album: "Album 1"),
//   Song(
//       url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
//       name: "Song 2",
//       artist: "Artist 2",
//       duration: Duration(minutes: 7, seconds: 5),
//       icon:
//           "https://i.pinimg.com/originals/1f/c6/69/1fc66962352f4f2cdef41af009215cc4.jpg",
//       album: "Album 2"),
//   Song(
//       url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
//       name: "Song 3",
//       duration: Duration(minutes: 5, seconds: 44),
//       artist: "Artist 3",
//       icon:
//           "https://i.pinimg.com/736x/ea/1f/64/ea1f64668a0af149a3277db9e9e54824.jpg",
//       album: "Album 3"),
//   Song(
//       url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
//       name: "Song 4",
//       artist: "Artist 4",
//       duration: Duration(minutes: 5, seconds: 2),
//       icon:
//           "https://magazine.artland.com/wp-content/uploads/2020/02/Webp.net-compress-image-67-1.jpg",
//       album: "Album 4")
// ];

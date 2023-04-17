import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helpers/shared_pref.dart';
import '../../Models/app_user_model.dart';
import '../../Models/chat_map_model.dart';
import '../../Models/movie_model.dart';

class FirestoreRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');
  CollectionReference chatFirebaseFirestore =
      FirebaseFirestore.instance.collection("chatRoom");

  CollectionReference matchFirebaseFirestore =
      FirebaseFirestore.instance.collection("matches");
  CollectionReference movieFirebaseFirestore =
      FirebaseFirestore.instance.collection("movies");

  Future<void> saveUserCredentials(
    String email,
    String firstName,
    String lastName,
    DateTime accountCreated,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'accountCreated': accountCreated,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> saveContinueWatching(String movieId, int duration) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    Map<String, dynamic> continueWatchingMap = {
      "movieId": movieId,
      "duration": duration,
    };
    await firebaseFirestore
        .doc(uid)
        .collection("continueWatching")
        .doc(movieId)
        .set(continueWatchingMap);
    return;
  }

  Future<void> updateUserCredentials({
    required String firstName,
    required String lastName,
  }) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'firstName': firstName,
          'lastName': lastName,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> storeNotificationToken() async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    String? token = await FirebaseMessaging.instance.getToken();

    await firebaseFirestore.doc(uid.toString()).set(
        {
          'messagetoken': token,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<AppUser?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  Stream<DocumentSnapshot<Object?>>? getUsersCredentialStream() {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = appUser.snapshots();
      return snapshot;

      // if (snapshot.) {
      //   return AppUser.fromJson(snapshot.data());
      // }
    } catch (error) {}
    return null;
  }

  Stream<QuerySnapshot<Object?>>? getContinueWatchingStream() {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid).collection("continueWatching");
      final snapshot = appUser.snapshots();
      return snapshot;

      // if (snapshot.) {
      //   return AppUser.fromJson(snapshot.data());
      // }
    } catch (error) {}
    return null;
  }

  Future<Movie?> GetMovieById(movieId) async {
    try {
      final movies = movieFirebaseFirestore.doc(movieId);
      final snapshot = await movies.get();

      if (snapshot.exists) {
        return Movie.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  Future<List<Movie>> getUserMovies(List<dynamic> movieIds) async {
    List<Movie> movies = [];
    try {
      for (var movieId in movieIds) {
        final movie = await movieFirebaseFirestore.doc(movieId).get();
        if (movie.exists) {
          movies.add(Movie.fromJson(movie.data()));
        }
      }
    } catch (error) {
      print('Error retrieving movies: $error');
    }
    return movies;
  }

//   Stream<AppUser?> getUsersCredentials() {
//   final userController = StreamController<AppUser?>();

//   try {
//     String uid = firebaseAuth.currentUser!.uid;

//     final appUser = firebaseFirestore.doc(uid);

//     appUser.snapshots().listen((snapshot) {
//       if (snapshot.exists) {
//         final appUser = AppUser.fromJson(snapshot.data());
//         // Add the continue watching property to the appUser object here
//         appUser.continueWatching = ... // Add your logic here to get the continueWatching property
//         userController.add(appUser);
//       } else {
//         userController.add(null);
//       }
//     });
//   } catch (error) {
//     userController.add(null);
//   }

//   return userController.stream;
// }

  Future<List<Movie>?> getAllMovies() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      List<Movie> allMovies = [];
      final movies = await movieFirebaseFirestore.get();
      if (movies.docs.isNotEmpty) {
        // List<Movie> allMovies =
        //     movies.docs.map((doc) => Movie.fromJson(doc)).toList();
        for (var movie in movies.docs) {
          var newMovie = Movie.fromJson(movie);

          if (SharedPreferenceHelper()
                  .getFromLocalCache(sharedPreferences, movie.id) ==
              null) {
            SharedPreferenceHelper().saveToLocalCache(key: movie.id, value: 0);
          }
          allMovies.add(newMovie);
        }
        print(allMovies);
        print(allMovies);
        return allMovies;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  Future<List<Movie>?> getAllTrendingMovies() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      List<Movie> allMovies = [];
      final trendingmovies =
          movieFirebaseFirestore.where("trending", isEqualTo: true);
      final movies = await trendingmovies.get();
      if (movies.docs.isNotEmpty) {
        // List<Movie> allMovies =
        //     movies.docs.map((doc) => Movie.fromJson(doc)).toList();
        for (var movie in movies.docs) {
          var newMovie = Movie.fromJson(movie);

          if (SharedPreferenceHelper()
                  .getFromLocalCache(sharedPreferences, movie.id) ==
              null) {
            SharedPreferenceHelper().saveToLocalCache(key: movie.id, value: 0);
          }
          allMovies.add(newMovie);
        }
        print(allMovies);
        print(allMovies);
        return allMovies;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  Future<List<Movie>?> getAllRecommendedMovies() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      List<Movie> allMovies = [];
      final trendingmovies =
          movieFirebaseFirestore.where("recommended", isEqualTo: true);
      final movies = await trendingmovies.get();
      if (movies.docs.isNotEmpty) {
        // List<Movie> allMovies =
        //     movies.docs.map((doc) => Movie.fromJson(doc)).toList();
        for (var movie in movies.docs) {
          var newMovie = Movie.fromJson(movie);

          if (SharedPreferenceHelper()
                  .getFromLocalCache(sharedPreferences, movie.id) ==
              null) {
            SharedPreferenceHelper().saveToLocalCache(key: movie.id, value: 0);
          }
          allMovies.add(newMovie);
        }
        print(allMovies);
        print(allMovies);
        return allMovies;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  Future<AppUser?> getUsersCredentialsbyid(String uid) async {
    try {
      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  Future<AppUser?> saveUsersCredentialslocal() async {
    try {
      AppUser? user = await getUsersCredentials();

      print(user);

      if (user != null) {
        final userJson = json.encode(user.toJson());

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userJson);
      }
    } catch (error) {}
    return null;
  }

  createChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    await chatFirebaseFirestore
        .doc(chatRoomId)
        .set(
            chatRoom,
            SetOptions(
              merge: true,
            ))
        .catchError((e) {
      print(e);
    });
  }

  Future<void> openChatroom(
      String currentUserName, String invitedUserName) async {
    List<String> users = [currentUserName, invitedUserName];

    String chatRoomId =
        await createChatRoomId(currentUserName, invitedUserName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    await addChatRoom(chatRoom, chatRoomId);
  }

  Future<void>? initalizeChat(String chatRoomId, chatMessageData) {
    chatFirebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
    return null;
  }

  Future<void> sendMessage(
      {required String message,
      required String currentUserId,
      required String chatRoomId,
      required DateTime time}) async {
    if (message.isNotEmpty) {
      AppUser? listenerUser = await getUsersCredentialsbyid(currentUserId);
      Map<String, dynamic> chatMessageMap = {
        "sendBy": currentUserId,
        "message": message,
        'time': time,
      };

      await initalizeChat(chatRoomId, chatMessageMap);
    }
  }

  getChats(String chatRoomId) async {
    return chatFirebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getUsers(String chatRoomId) async {
    return firebaseFirestore
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String currentUserId) async {
    return chatFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .orderBy("lastMessageSendTime", descending: true)
        .snapshots();
  }

  Future<Stream<DocumentSnapshot>> getCurrentUserProfile() async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    return firebaseFirestore.doc(uid).snapshots();
  }

  Future<Stream<QuerySnapshot>> getAllUsers(String mainUserId) async {
    return firebaseFirestore
        .orderBy("id", descending: true)
        .where("id", isNotEqualTo: mainUserId)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> checkTheUsers(
      currentUserId, buddyUserId) async {
    String matchId = await createChatRoomId(currentUserId, buddyUserId);
    return matchFirebaseFirestore
        .where("matchId", isNotEqualTo: matchId)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String buddyUserId) async {
    return await firebaseFirestore.where("id", isEqualTo: buddyUserId).get();
  }

  Future<AppUser?> getThisUserInfo(
      String chatRoomId, String currentUserId) async {
    String? buddyUserId =
        chatRoomId.replaceAll(currentUserId, "").replaceAll("_", "");

    AppUser? buddyDetails = await getUsersCredentialsbyid(buddyUserId);
    return buddyDetails;
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return chatFirebaseFirestore.doc(chatRoomId).set(
        lastMessageInfoMap,
        SetOptions(
          merge: true,
        ));
  }

  Future<String> getUserTokenbyid(String uid) async {
    try {
      final appUser = firebaseFirestore.doc(uid);
      var snapshot = await appUser.get();

      if (snapshot.exists) {
        dynamic data = snapshot.data();
        String value = data?['token'];
        return value;
      }
    } catch (error) {}
    return '';
  }

  Future<UnreadModel?> getUserunreadbyid({
    required String currentUserId,
    required String invitedUserId,
  }) async {
    try {
      String matchId = await createChatRoomId(currentUserId, invitedUserId);
      final appUser = chatFirebaseFirestore.doc(matchId);
      var snapshot = await appUser.get();

      if (snapshot.exists) {
        dynamic data = snapshot.data();
        int unreadCount = data?['unreadCount'];
        String unreadBy = data?['unreadBy'];
        UnreadModel result =
            UnreadModel(unreadBy: unreadBy, unreadCount: unreadCount);
        return result;
      }
    } catch (error) {}
    return null;
  }

  Future<void>? updateUnreadCount(
      {required String chatRoomId,
      required String unreadBy,
      required int unreadCount}) async {
    chatFirebaseFirestore.doc(chatRoomId).set(
        {
          "unreadCount": unreadCount,
          "unreadBy": unreadBy,
        },
        SetOptions(
          merge: true,
        )).catchError((e) {
      print(e.toString());
    });
    return;
  }
}

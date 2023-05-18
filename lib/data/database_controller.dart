import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  List listMovieId = [];
  var getStatusMovie = false.obs;

  void writeDataMovie(String userId, int movieId, String title, 
      String posterPath,) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("Users/$userId");
    ref.push().set({
      "movieId": movieId,
      "title": title,
      "posterPath": posterPath,
    });
  }

  void readDataMovie(String userId) {
    listMovieId = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users/$userId");
    ref.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        values.forEach((key, values) {
          if (!listMovieId.contains(values['movieId'])) {
            listMovieId.add({
              "movieId": values['movieId'],
              "title": values['title'],       
              "posterPath": values['posterPath'],   
            });
          }
        });
        update();
      }
    });
  }

  getIdMovie(String userId, int movieId) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("Users/$userId");

    ref.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map;
        values.forEach((key, values) {
          if (values['movieId'] == movieId) {
            getStatusMovie(true);
          }
        });
      }
    });
  }

  void deleteMovie(String userId, int movieId) {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("Users/$userId");
    ref.once().then((DatabaseEvent event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map;
      values.forEach((key, value) {
        if (value['movieId'] == movieId) {
          ref.child(key).remove();
        }
      });
    });
  }

  void deleteMovieInList(int movieId) {
    for (int i = 0; i < listMovieId.length; i++) {
      if (listMovieId[i]['movieId'] == movieId) {
        listMovieId.removeAt(i);
        break;
      }
    }
    update();
  }
}
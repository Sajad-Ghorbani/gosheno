import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/activity_model.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityController extends GetxController {
  final UserRepository _userRepository;
  final BookRepository _bookRepository;

  ActivityController(this._userRepository, this._bookRepository);

  List<Activity> activities = [];
  List<Book> books = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getUserActivity();
  }

  void getUserActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt(AppConstants.userIdKey) ?? 0;
    var response = await _userRepository.getUserActivities(id: userId);
    if (response['status']) {
      activities = response['activities'];
      await getBooks(activities);
    }
    isLoading = false;
    update();
  }

  getBooks(List<Activity> activities) async {
    for (var item in activities) {
      var response = await _bookRepository.getSimpleBookInfo(
          bookId: int.parse(item.bookId));
      if (response['status']) {
        books.add(response['book']);
      }
    }
  }
}

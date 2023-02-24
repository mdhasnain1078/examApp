import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/controller/auth_controller.dart';
import 'package:examapp/firebase_ref/refrence.dart';
import 'package:examapp/models/question_paper_model.dart';
import 'package:examapp/screen/question/question_screen.dart';
import 'package:examapp/service/firebase_storage_service.dart';
import 'package:get/get.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ['physics', 'chemistry', 'biology', 'maths'];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);
      for (var paper in allPapers) {
        final imgUrl =
            await Get.put(FirebaseStorageService()).getImage(paper.title);
        allPaperImages.add(imgUrl!);
        paper.imageUrl = imgUrl;
      }
      // allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestion(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialogue();
    }
  }
}

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/firebase_ref/loading_status.dart';
import 'package:examapp/firebase_ref/refrence.dart';
import 'package:examapp/models/question_paper_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; // loadingstatus is obs
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; // 0
    final firestore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap =
        json.decode(manifestContent) as Map<String, dynamic>;
    // load json file and print path
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> quesitionPaper = [];
    for (var paper in papersInAssets) {
      String stringPaperContaint = await rootBundle.loadString(paper);
      quesitionPaper
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContaint)));
    }
    // print('Items number ${quesitionPaper[0].id}');
    var batch = firestore.batch();
    for (var paper in quesitionPaper) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_second": paper.timeSeconds,
        "question_count": paper.questions == null ? 0 : paper.questions!.length
      });
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id!, questionId: questions.id!);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var answer in questions.answers!) {
          batch.set(questionPath.collection('answer').doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
          print('3');
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}

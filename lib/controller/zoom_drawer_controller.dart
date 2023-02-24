import 'package:examapp/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDreaweController = ZoomDrawerController();

  Rxn<User?> user = Rxn();
  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDreaweController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {}

  void website() {}

  void facebook() {
    // _launch("https//:www.facebook.com");
  }

  void email() {
    // final Uri emailLauncherUri =
    //     Uri(scheme: 'mailto', path: 'hasnainshaikh62479@gmail.com');
    // _launch(emailLauncherUri.toString());
  }

  Future<void> _launch(String url) async {
    // if (!await launch(url)) {
    //   throw 'could not launch $url';
    // }
  }
}

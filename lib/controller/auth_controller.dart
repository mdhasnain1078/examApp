import 'package:examapp/Home/home_page.dart';
import 'package:examapp/firebase_ref/refrence.dart';
import 'package:examapp/screen/login_screen/login_screen.dart';
import 'package:examapp/widgets/dialogs/dialogue_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) => _user.value = user);
    navigateToIntroduction();
  }

  void showLoginAlertDialogue() {
    Get.dialog(Dialogs.questionStartDialogue(onTap: () {
      Get.back();
      navigateToLoginPage();
    }), barrierDismissible: false);
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  singInWithGoogle() async {
    final GoogleSignIn googleSingIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSingIn.signIn();
      if (account != null) {
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: authAccount.idToken, accessToken: authAccount.accessToken);
        await _auth.signInWithCredential(credential);
        await saveUser(account);
        navigateToHomeScreen();
      }
    } on Exception catch (error) {
      // AppLogger.e(error);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }

  signOut() async {
    try {
      await _auth.signOut();
      navigateToHomeScreen();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed(
      "/introduction",
    );
  }

  void navigateToHomeScreen() {
    Get.offAllNamed(
      HomePage.routeName,
    );
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}

import 'package:examapp/Home/home_page.dart';
import 'package:examapp/controller/question_paper/questions_controller.dart';
import 'package:examapp/controller/question_paper_controller.dart';
import 'package:examapp/controller/zoom_drawer_controller.dart';
import 'package:examapp/screen/introduction/introduction.dart';
import 'package:examapp/screen/login_screen/login_screen.dart';
import 'package:examapp/screen/question/answer_check_screen.dart';
import 'package:examapp/screen/question/question_screen.dart';
import 'package:examapp/screen/question/result_screen.dart';
import 'package:examapp/screen/question/test_overview_screen.dart';
import 'package:examapp/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomePage(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => const QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        )
      ];
}

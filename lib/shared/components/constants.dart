import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/boarding_model/boarding_model.dart';
import 'package:shop_app/modules/auth/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String? token;
bool? isLight;
bool? onBoarding;
String testImage = "assets/images/test.jpg";
int testPrice = 1200;
int testOldPrice = 1000;
String testName =
    "name name name name name name name namename name name namename name name name";
List<BoardingModel> boardingList = [
  BoardingModel(
    image: 'link of image 1',
    title: 'title 1',
    body: 'body text 1',
  ),
  BoardingModel(
    image: 'link of image 2',
    title: 'title 2',
    body: 'body text 2',
  ),
  BoardingModel(
    image: 'link of image 3',
    title: 'title 3',
    body: 'body text 3',
  ),
];

void signOut({
  required BuildContext context,
}) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndReplace(
      context: context,
      widget: const LoginScreen(),
    );
  });
}

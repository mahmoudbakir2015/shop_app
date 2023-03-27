import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubitShop extends Cubit<AppShopStates> {
  AppCubitShop()
      : super(
          AppInitialShopStates(),
        );

  static AppCubitShop get(context) => BlocProvider.of(context);
  bool lightMode = true;

  void changeMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      lightMode = fromShared;
    } else {
      lightMode = !lightMode;
      CacheHelper.saveData(
        value: lightMode,
        key: 'isLight',
      ).then((value) async {
        // print(
        //   await CacheHelper.getData(key: 'isLight') as bool,
        // );
        emit(
          AppShopChangeMode(),
        );
      });
    }
  }
}

//
// int currentIndex = 0;
// bool lightMode = true;
//
// List<BottomNavigationBarItem> bottomNavItem = const [
//   BottomNavigationBarItem(
//     label: 'Business',
//     icon: Icon(
//       Icons.business,
//     ),
//   ),
//   BottomNavigationBarItem(
//     label: 'Sciences',
//     icon: Icon(
//       Icons.science,
//     ),
//   ),
//   BottomNavigationBarItem(
//     label: 'Sports',
//     icon: Icon(
//       Icons.sports,
//     ),
//   ),
// ];
//
// void changePage({
//   required int index,
// }) {
//   currentIndex = index;
//   if (index == 1) {
//     getSciences();
//   } else if (index == 2) {
//     getSports();
//   }
//   emit(
//     AppBottomNavNewsStates(),
//   );
// }
//

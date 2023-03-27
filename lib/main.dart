import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_layout.dart';
import 'package:shop_app/modules/auth/login/cubit/cubit_login.dart';
import 'package:shop_app/modules/auth/login/login_screen.dart';
import 'package:shop_app/modules/auth/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/observer_block.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  isLight = await CacheHelper.getData(
    key: 'isLight',
  );
  Widget widget;
  onBoarding = await CacheHelper.getData(
    key: 'onBoarding',
  );
  token = await CacheHelper.getData(
    key: 'token',
  );
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }
  runApp(
    MyApp(
      isLight: isLight ?? true,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLight;
  final Widget startWidget;
  const MyApp({
    super.key,
    required this.isLight,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubitShop()
            ..changeMode(
              fromShared: isLight,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeLayoutCubit()
            ..getHomeData()
            ..getCategories()
            ..getMyFavData()
            ..getProfile(),
        ),
      ],
      child: BlocConsumer<AppCubitShop, AppShopStates>(
        listener: (
          BuildContext context,
          AppShopStates states,
        ) {},
        builder: (
          BuildContext context,
          AppShopStates states,
        ) {
          AppCubitShop cubit = AppCubitShop.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: cubit.lightMode ? ThemeMode.light : ThemeMode.dark,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}

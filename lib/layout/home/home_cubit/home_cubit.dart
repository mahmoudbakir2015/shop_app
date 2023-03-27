import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/favourite_model/change_fav_model.dart';
import 'package:shop_app/models/favourite_model/fav_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/screens/categories/categories_screen.dart';
import 'package:shop_app/modules/screens/favourite/favourite_screen.dart';
import 'package:shop_app/modules/screens/products/products_screen.dart';
import 'package:shop_app/modules/screens/settings/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutShopStates> {
  HomeLayoutCubit()
      : super(
          HomeLayoutInitialState(),
        );

  static HomeLayoutCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<int?, bool?> myFavourite = {};
  HomeModel? homeModel;
  Products? products;
  ChangeFavoritesModel? changeFavorites;
  CategoryModel? categoryModel;
  FavModel? favModel;
  LoginModel? loginModel;
  int currentIndex = 0;
  List<Widget> screens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItem = const [
    BottomNavigationBarItem(
      label: 'Products',
      icon: Icon(
        Icons.production_quantity_limits,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Categories',
      icon: Icon(
        Icons.category,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Favourites',
      icon: Icon(
        Icons.favorite,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(
        Icons.settings,
      ),
    ),
  ];

  void changePage({
    required int index,
  }) {
    currentIndex = index;
    emit(
      HomeLayoutChangeBottomNavState(),
    );
  }

  void getHomeData() {
    emit(
      HomeLayoutDataLoadingState(),
    );

    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        myFavourite.addAll({
          element.id: element.inFavorites,
        });
      }
      emit(
        HomeLayoutDataSuccessState(),
      );
    }).catchError((error) {
      emit(
        HomeLayoutDataErrorState(
          error.toString(),
        ),
      );
    });
  }

  void getCategories() {
    emit(
      HomeLayoutDataLoadingCategoriesState(),
    );

    DioHelper.getData(
      url: categories,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(
        HomeLayoutDataSuccessCategoriesState(),
      );
    }).catchError((error) {
      emit(
        HomeLayoutDataErrorCategoriesState(
          error.toString(),
        ),
      );
    });
  }

  void getMyFavData() {
    emit(
      HomeLayoutDataLoadingMyFavState(),
    );

    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      favModel = FavModel.fromJson(value.data);

      emit(
        HomeLayoutDataSuccessMyFavState(),
      );
    }).catchError((error) {
      emit(
        HomeLayoutDataErrorMyFavState(
          error.toString(),
        ),
      );
    });
  }

  void changeFavourites(int? productId) {
    emit(
      HomeLayoutDataLoadingChangeFavState(),
    );
    myFavourite[productId] = !myFavourite[productId]!;
    emit(
      HomeLayoutDataSuccessChangeFavState(),
    );
    DioHelper.postData(
      url: favorites,
      data: {
        "product_id": productId,
      },
      token: token,
    ).then(
      (value) {
        changeFavorites = ChangeFavoritesModel.fromJson(value.data);
        if (changeFavorites?.status == false) {
          myFavourite[productId] = !myFavourite[productId]!;
        } else {
          getMyFavData();
        }
        emit(
          HomeLayoutDataSuccessChangeFavState(),
        );
      },
    ).catchError(
      (error) {
        myFavourite[productId] = !myFavourite[productId]!;
        emit(
          HomeLayoutDataErrorChangeFavState(
            error.toString(),
          ),
        );
      },
    );
  }

  void getProfile() {
    emit(
      HomeLayoutProfileLoadingState(),
    );

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(
        HomeLayoutProfileSuccessState(),
      );
    }).catchError((error) {
      emit(
        HomeLayoutProfileErrorState(
          error.toString(),
        ),
      );
    });
  }

  void updateUserProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(HomeLayoutUpDateProfileLoadingState());
    DioHelper.putData(
      url: updateProfile,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      token: token,
    ).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(HomeLayoutUpDateProfileSuccessState());
      },
    ).catchError(
      (error) {
        emit(HomeLayoutUpDateProfileErrorState(error.toString()));
      },
    );
  }
}

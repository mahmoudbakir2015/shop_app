import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/auth/login/cubit/states_login.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit()
      : super(
          ShopLoginInitialState(),
        );
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool obscureText = true;
  LoginModel? loginModel;
  void changeVisibleIcon() {
    obscureText = !obscureText;
    emit(
      ShopLoginIconVisibleState(),
    );
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(
      ShopLoginLoadingState(),
    );

    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(
          ShopLoginSuccessState(loginModel),
        );
      },
    ).catchError(
      (error) {
        emit(
          ShopLoginErrorState(
            error.toString(),
          ),
        );
      },
    );
  }
}

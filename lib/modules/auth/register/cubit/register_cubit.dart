import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_layout.dart';
import 'package:shop_app/models/register_model/register_model.dart';
import 'package:shop_app/modules/auth/register/cubit/register_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit()
      : super(
          ShopInitialRegState(),
        );
  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegisterModel? registerModel;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool obscureText = true;

  void changeVisibleIcon() {
    obscureText = !obscureText;
    emit(
      ShopChangeIconPasssRegState(),
    );
  }

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(
      ShopRegisterLoadingState(),
    );

    DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        registerModel = RegisterModel.fromJson(value.data);
        emit(
          ShopRegisterSuccessState(registerModel),
        );
      },
    ).catchError(
      (error) {

        emit(
          ShopRegisterErrorState(
            error.toString(),
          ),
        );
      },
    );
  }

  void createAccount(cubit, state, context) {
    cubit.userRegister(
      email: cubit.emailController.text,
      password: cubit.passwordController.text,
      name: cubit.nameController.text,
      phone: cubit.phoneController.text,
    );
    if (state is ShopRegisterSuccessState) {
      if (state.registerModel!.status!) {
        CacheHelper.saveData(
          key: 'token',
          value: state.registerModel?.data?.token,
        ).then((value) {
          token = state.registerModel!.data!.token;
          navigateAndReplace(
            context: context,
            widget: const HomeLayout(),
          );
        });
      } else {
        buildToast(
          msg: '${state.registerModel!.message}',
          state: ToastStates.error,
        );
      }
    }
  }
}

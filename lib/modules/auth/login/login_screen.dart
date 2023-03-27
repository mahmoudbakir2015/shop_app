import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_layout.dart';
import 'package:shop_app/modules/auth/login/cubit/cubit_login.dart';
import 'package:shop_app/modules/auth/login/cubit/states_login.dart';
import 'package:shop_app/modules/auth/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (BuildContext context, ShopLoginStates state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel!.status!) {
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel?.data?.token,
            ).then((value) {
              token = state.loginModel!.data!.token;
              navigateAndReplace(
                context: context,
                widget: const HomeLayout(),
              );
            });
          } else {
            buildToast(
              msg: '${state.loginModel!.message}',
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (BuildContext context, ShopLoginStates state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'login now to browse our hot offer',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        label: 'E-mail',
                        controller: cubit.emailController,
                        textInputType: TextInputType.emailAddress,
                        prefIcon: Icons.email,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return "email should not to be empty !!!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        onTap: () {
                          cubit.changeVisibleIcon();
                        },
                        isPassword: cubit.isPassword,
                        onSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text,
                            );
                          }
                        },
                        label: 'Password',
                        obscureText: cubit.obscureText,
                        controller: cubit.passwordController,
                        textInputType: TextInputType.visiblePassword,
                        prefIcon: Icons.password,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return "password is short !!!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is! ShopLoginLoadingState
                          ? defaultButton(
                              text: 'Login ',
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                  );
                                }
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                          ),
                          defaultTextButton(
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: const RegisterScreen(),
                              );
                            },
                            text: 'create account',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

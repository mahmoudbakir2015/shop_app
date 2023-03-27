import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_layout.dart';
import 'package:shop_app/modules/auth/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/auth/register/cubit/register_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, ShopRegisterStates>(
      listener: (BuildContext context, ShopRegisterStates state) {
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
      },
      builder: (BuildContext context, ShopRegisterStates state) {
        RegisterCubit cubit = RegisterCubit.get(context);
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
                        "SIGN UP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'Sign Up now to browse our hot offer',
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
                        label: 'Name',
                        controller: cubit.nameController,
                        textInputType: TextInputType.name,
                        prefIcon: Icons.person,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return "Name should not to be empty !!!";
                          } else if (value.length < 2) {
                            return "Name should not to be  less than 2 !!!";
                          }
                          // else if (value.contains(pattern.toString())) {
                          //   return "Name should not contain num !!!";
                          // }
                          else {
                            return null;
                          }
                        },
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
                          } else if (!value.contains("@")) {
                            return "email should  like ....@gm.com !!!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextForm(
                        label: 'Phone',
                        controller: cubit.phoneController,
                        textInputType: TextInputType.phone,
                        prefIcon: Icons.phone,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return "Phone should not to be empty  !!!";
                          } else if (value.length < 11) {
                            return "Phone greater than 10!!!";
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
                        label: 'Password',
                        obscureText: cubit.obscureText,
                        controller: cubit.passwordController,
                        textInputType: TextInputType.visiblePassword,
                        prefIcon: Icons.password,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return "password is empty !!!";
                          } else if (value.length < 8) {
                            return "password should greater than 8 !!!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is! ShopRegisterLoadingState
                          ? defaultButton(
                              text: 'Sign Up ',
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                    name: cubit.nameController.text,
                                    phone: cubit.phoneController.text,
                                  );
                                }
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
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

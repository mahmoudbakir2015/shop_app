import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutShopStates>(
      listener: (BuildContext context, HomeLayoutShopStates state) {},
      builder: (BuildContext context, HomeLayoutShopStates state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        LoginModel? user = HomeLayoutCubit.get(context).loginModel;
        cubit.phoneController.text = user!.data!.phone!;
        cubit.nameController.text = user.data!.name!;
        cubit.emailController.text = user.data!.email!;
        return Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  if (state is HomeLayoutUpDateProfileLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextForm(
                    label: 'Name',
                    controller: cubit.nameController,
                    textInputType: TextInputType.name,
                    prefIcon: Icons.person,
                    onValidate: (String? value) {
                      if (value!.isEmpty) {
                        return "name should be not empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextForm(
                    label: 'Email Address',
                    controller: cubit.emailController,
                    textInputType: TextInputType.emailAddress,
                    prefIcon: Icons.email,
                    onValidate: (String? value) {
                      if (value!.isEmpty) {
                        return "Email Address should be not empty";
                      }
                      return null;
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
                        return "phone Number should be not empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: "UpDate",
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.updateUserProfile(
                          name: cubit.nameController.text,
                          phone: cubit.phoneController.text,
                          email: cubit.emailController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: "Logout",
                    onPressed: () {
                      signOut(
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

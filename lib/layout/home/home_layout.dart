import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/modules/screens/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutShopStates>(
      listener: (BuildContext context, HomeLayoutShopStates state) {},
      builder: (BuildContext context, HomeLayoutShopStates state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: SearchScreen(
                      model: cubit.products,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changePage(
                index: index,
              );
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavItem,
          ),
        );
      },
    );
  }
}

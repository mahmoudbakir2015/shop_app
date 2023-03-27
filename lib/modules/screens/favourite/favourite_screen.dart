import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/modules/screens/favourite/componnents/componnents.dart';
import 'package:shop_app/shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutShopStates>(
      listener: (BuildContext context, HomeLayoutShopStates state) {},
      builder: (BuildContext context, HomeLayoutShopStates state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return cubit.favModel!.data!.data!.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.favModel!.data!.data!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    myDivider(),
                itemBuilder: (BuildContext context, int index) =>
                    buildFavouriteItem(
                  cubit.favModel!.data!.data![index],
                  context,
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text("No favourite yet !!!"),
                  ],
                ),
              );
      },
    );
  }
}

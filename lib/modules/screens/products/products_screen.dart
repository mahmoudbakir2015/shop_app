import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/modules/screens/products/components/components.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutShopStates>(
        listener: (BuildContext context, HomeLayoutShopStates state) {},
        builder: (BuildContext context, HomeLayoutShopStates state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return cubit.homeModel != null && cubit.categoryModel != null
              ? builderWidgets(
                  cubit.homeModel!,
                  cubit.categoryModel!,
                  context,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text("check network !!!"),
                    ],
                  ),
                );
        });
  }
}

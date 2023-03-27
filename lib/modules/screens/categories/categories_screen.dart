import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home/home_cubit/home_states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutShopStates>(
      listener: (BuildContext context, HomeLayoutShopStates state) {},
      builder: (BuildContext context, HomeLayoutShopStates state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return cubit.categoryModel != null
            ? ListView.separated(
                itemCount: cubit.categoryModel!.data!.data!.length,
                separatorBuilder: (BuildContext context, int index) =>
                    myDivider(),
                itemBuilder: (BuildContext context, int index) =>
                    buildCatItem(cubit.categoryModel!.data!.data![index]),
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
      },
    );
  }

  Widget buildCatItem(DataCategory data) {
    return Padding(
      padding: const EdgeInsets.all(
        20,
      ),
      child: GestureDetector(
        onTap: () {
        },
        child: Row(
          children: [
            Image(
              height: 100,
              width: 100,
              image: NetworkImage(
                data.image.toString(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data.name.toString().toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/screens/search/search_cubit/componnents/componnents.dart';
import 'package:shop_app/modules/screens/search/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/screens/search/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final Products? model;
  const SearchScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (BuildContext context, ShopSearchStates state) {},
        builder: (BuildContext context, ShopSearchStates state) {
          ShopSearchCubit cubit = ShopSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                children: [
                  defaultTextForm(
                    label: 'Search',
                    controller: cubit.searchController,
                    textInputType: TextInputType.text,
                    onValidate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      cubit.searchProduct(
                        text: value,
                      );
                    },
                    prefIcon: Icons.search,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is ShopLoadingSearchState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is ShopSuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.searchModel!.data!.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            myDivider(),
                        itemBuilder: (BuildContext context, int index) =>
                            buildProductSearchItem(
                          cubit.searchModel!.data!.data![index],
                          context,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

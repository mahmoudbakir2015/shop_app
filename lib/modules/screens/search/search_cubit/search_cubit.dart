import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/screens/search/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit()
      : super(
          ShopInitialSearchState(),
        );

  static ShopSearchCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  SearchModel? searchModel;
  List<dynamic> search = [];

  void searchProduct({
    required String text,
  }) {
    emit(
      ShopLoadingSearchState(),
    );
    DioHelper.postData(
      url: productsSearch,
      token: token,
      data: {
        'text': text,
      },
    ).then(
      (value) {
        searchModel = SearchModel.fromJson(value.data);
        // search.add(searchModel!.data);
        print(value.data);
        emit(
          ShopSuccessSearchState(),
        );
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorSearchState(
          error.toString(),
        ));
      },
    );
  }
}

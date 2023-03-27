import 'package:shop_app/models/register_model/register_model.dart';

abstract class ShopRegisterStates {}

class ShopInitialRegState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final RegisterModel? registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopChangeIconPasssRegState extends ShopRegisterStates {}

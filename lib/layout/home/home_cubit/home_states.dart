abstract class HomeLayoutShopStates {}

class HomeLayoutInitialState extends HomeLayoutShopStates {}

class HomeLayoutChangeBottomNavState extends HomeLayoutShopStates {}

class HomeLayoutDataLoadingState extends HomeLayoutShopStates {}

class HomeLayoutDataSuccessState extends HomeLayoutShopStates {}

class HomeLayoutDataErrorState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutDataErrorState(this.error);
}

class HomeLayoutDataLoadingCategoriesState extends HomeLayoutShopStates {}

class HomeLayoutDataSuccessCategoriesState extends HomeLayoutShopStates {}

class HomeLayoutDataErrorCategoriesState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutDataErrorCategoriesState(this.error);
}

class HomeLayoutDataLoadingMyFavState extends HomeLayoutShopStates {}

class HomeLayoutDataSuccessMyFavState extends HomeLayoutShopStates {}

class HomeLayoutDataErrorMyFavState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutDataErrorMyFavState(this.error);
}

class HomeLayoutDataSuccessChangeFavState extends HomeLayoutShopStates {}

class HomeLayoutDataLoadingChangeFavState extends HomeLayoutShopStates {}

class HomeLayoutDataErrorChangeFavState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutDataErrorChangeFavState(this.error);
}

class HomeLayoutProfileLoadingState extends HomeLayoutShopStates {}

class HomeLayoutProfileSuccessState extends HomeLayoutShopStates {}

class HomeLayoutProfileErrorState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutProfileErrorState(this.error);
}

class HomeLayoutUpDateProfileLoadingState extends HomeLayoutShopStates {}

class HomeLayoutUpDateProfileSuccessState extends HomeLayoutShopStates {}

class HomeLayoutUpDateProfileErrorState extends HomeLayoutShopStates {
  final String error;
  HomeLayoutUpDateProfileErrorState(this.error);
}

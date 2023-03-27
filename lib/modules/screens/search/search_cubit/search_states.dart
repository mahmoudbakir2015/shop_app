abstract class ShopSearchStates {}

class ShopInitialSearchState extends ShopSearchStates {}

class ShopLoadingSearchState extends ShopSearchStates {}

class ShopSuccessSearchState extends ShopSearchStates {}

class ShopErrorSearchState extends ShopSearchStates {
  final String error;
  ShopErrorSearchState(this.error);
}

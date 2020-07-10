import 'package:bloc/bloc.dart';
import 'package:martkh/pages/franchise/franchisePage.dart';
import 'package:martkh/pages/stock/stock.dart';
import '../pages/account/accountpage.dart';
import '../pages/homepage/homepage.dart';
import '../pages/wishlist/wishlist.dart';
import '../pages/stock/stock.dart';

enum NavigationEvents {
  HomePageCLickedEvent,
  MyAccountClickedEvent,
  WishListPageClickedEvent,
  StockRequestClickedEvent,
  FranchiseClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // NavigationStates get initialState => throw UnimplementedError();
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    // throw UnimplementedError();
    switch (event) {
      case NavigationEvents.HomePageCLickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield AcccountsPage();
        break;
      case NavigationEvents.WishListPageClickedEvent:
        yield WishList();
        break;
      case NavigationEvents.StockRequestClickedEvent:
        yield StockManagement();
        break;
      case NavigationEvents.FranchiseClickedEvent:
        yield FranchisePage();
        break;
    }
  }
}

import 'package:flutter/material.dart';

///This service can be used in the View Models to navigate without context
///
///[pop] function can be used to pop the routes
///
///[navigateTo] can be used to navigate to a named route
///
///[navigateToWidget] can be used to navigate to a widget
///
///[navigateAndRemove] navigates to a named route and removes all the other routes
///
///[navigateAndRemoveWidget] navigates to widget and removes all the other routes
///
///The navigation service can be instantiated using the locator.
///
/// ### Example
///```dart
/// final _navigationService = locator<NavigationService>();
/// ```
class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void pop() {
    return _navigatorKey.currentState!.pop();
  }

  void popAwait({required String key, required dynamic value}) {
    _navigatorKey.currentState!.pop({key: value});
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementToWidget(Widget page) {
    return _navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => page));
  }

  Future<dynamic> navigateToWidget(Widget page) {
    return _navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  Future<dynamic> navigateAndRemove(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> navigateAndRemoveWidget(Widget page) {
    return _navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => page),
        (Route<dynamic> route) => false);
  }

  Future<dynamic> navigateAndRemoveWidgetFade(Widget page) {
    return _navigatorKey.currentState!.pushAndRemoveUntil(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    ), (Route<dynamic> route) => false);
  }

  Future<dynamic> navigateToWidgetFade(Widget page) {
    return _navigatorKey.currentState!.push(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    ));
  }
}

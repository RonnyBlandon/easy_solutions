import 'package:flutter/material.dart';

//Pages
import 'package:easy_solutions/src/features/presentation/welcome_page/View/welcome_page.dart';
import 'package:easy_solutions/src/features/presentation/login_page/View/login_page.dart';
import 'package:easy_solutions/src/features/presentation/forgot_password_page/View/forgot_password_page.dart';
import 'package:easy_solutions/src/features/presentation/sign_up_page/View/sign_up_page.dart';
import 'package:easy_solutions/src/features/presentation/services_page/View/services_page.dart';
import 'package:easy_solutions/src/features/presentation/tabs/tabs_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/View/restaurant_list_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/View/restaurant_menu_page.dart';
import 'package:easy_solutions/src/features/presentation/menu_details_page/View/menu_details_page.dart';
import 'package:easy_solutions/src/features/presentation/shopping_cart_page/View/shopping_cart_page.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => const WelcomePage(),
  'login': (BuildContext context) => const LoginPage(),
  'forgot_password': (BuildContext context) => const ForgotPassword(),
  'sign_up': (BuildContext context) => const SignUpPage(),
  'services': (BuildContext context) => const ServicesPage(),
  'tabs': (BuildContext context) => const TabsPage(),
  'restaurant_list': (BuildContext context) => const RestaurantListPage(),
  'restaurant_menu': (BuildContext context) => const RestaurantMenuPage(),
  'menu_details': (BuildContext context) => const MenuDetailsPage(),
  'shopping_cart': (BuildContext context) => const ShoppingCartPage()
};

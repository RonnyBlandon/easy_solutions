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
import 'package:easy_solutions/src/features/presentation/product_details_page/View/product_details_page.dart';
import 'package:easy_solutions/src/features/presentation/shopping_cart_page/View/shopping_cart_page.dart';
import 'package:easy_solutions/src/features/presentation/order_details_page/View/order_details_page.dart';
import 'package:easy_solutions/src/features/presentation/profile_details_page/View/profile_details_page.dart';
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/payment_methods_page.dart';
import 'package:easy_solutions/src/features/presentation/add_card_credit_page/View/add_card_credit.dart';
import 'package:easy_solutions/src/features/presentation/add_address_page/View/add_address_page.dart';
import 'package:easy_solutions/src/features/presentation/legal_info_page/View/legal_info_page.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/View/business_list_page.dart';
import 'package:easy_solutions/src/features/presentation/product_categories_page/View/product_categories_page.dart';
import 'package:easy_solutions/src/features/presentation/product_category_page/View/product_category_page.dart';
import 'package:easy_solutions/src/features/presentation/search_page/View/search_page.dart';
import 'package:easy_solutions/src/features/presentation/notifications_page/View/notifications_page.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => const WelcomePage(),
  'login': (BuildContext context) => const LoginPage(),
  'forgot_password': (BuildContext context) => const ForgotPassword(),
  'sign_up': (BuildContext context) => const SignUpPage(),
  'services': (BuildContext context) => const ServicesPage(),
  'tabs': (BuildContext context) => const TabsPage(),
  'restaurant_list': (BuildContext context) => const RestaurantListPage(),
  'restaurant_menu': (BuildContext context) => const RestaurantMenuPage(),
  'product_details': (BuildContext context) => const ProductDetailsPage(),
  'shopping_cart': (BuildContext context) => const ShoppingCartPage(),
  'order_details': (BuildContext context) => const OrderDetailsPage(),
  'profile_details': (BuildContext context) => const ProfileDetailsPage(),
  'payment_methods': (BuildContext context) => const PaymentMethodsPage(),
  'legal_info': (BuildContext context) => const LegalInfoPage(),
  'form_add_card_credit': (BuildContext context) => const FormAddCardCredit(),
  'add_address': (BuildContext context) => const AddAddressPage(),
  'business_list': (BuildContext context) => const BusinessListPage(),
  'product_categories': (BuildContext context) => const ProductCategoriesPage(),
  'product_category': (BuildContext context) => const ProductCategoryPage(),
  'search': (BuildContext context) => const SearchPage(),
  'notifications': (BuildContext context) => const NotificationsPage()
};

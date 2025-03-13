import 'package:easy_solutions/src/features/presentation/profile/EditPasswordPage/View/edit_password_page.dart';
import 'package:flutter/material.dart';

//Pages
import 'package:easy_solutions/src/features/presentation/welcome_page/View/welcome_page.dart';
import 'package:easy_solutions/src/features/presentation/login_page/View/login_page.dart';
import 'package:easy_solutions/src/features/presentation/forgot_password_page/View/forgot_password_page.dart';
import 'package:easy_solutions/src/features/presentation/sign_up_page/View/sign_up_page.dart';
import 'package:easy_solutions/src/features/presentation/services_page/View/services_page.dart';
import 'package:easy_solutions/src/features/presentation/tabs/TabsPage/View/tabs_page.dart';
import 'package:easy_solutions/src/features/presentation/order_details_page/View/order_details_page.dart';
import 'package:easy_solutions/src/features/presentation/profile/profile_details_page/View/profile_details_page.dart';
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/payment_methods_page.dart';
import 'package:easy_solutions/src/features/presentation/add_card_credit_page/View/add_card_credit.dart';
import 'package:easy_solutions/src/features/presentation/add_address_page/View/add_address_page.dart';
import 'package:easy_solutions/src/features/presentation/legal_info_page/View/legal_info_page.dart';
import 'package:easy_solutions/src/features/presentation/notifications_page/View/notifications_page.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => const WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'forgot_password': (BuildContext context) => const ForgotPassword(),
  'sign_up': (BuildContext context) => SignUpPage(),
  'services': (BuildContext context) => const ServicesPage(),
  'tabs': (BuildContext context) => const TabsPage(),
  'order_details': (BuildContext context) => const OrderDetailsPage(),
  'profile_details': (BuildContext context) => const ProfileDetailsPage(),
  'payment_methods': (BuildContext context) => const PaymentMethodsPage(),
  'legal_info': (BuildContext context) => const LegalInfoPage(),
  'form_add_card_credit': (BuildContext context) => const FormAddCardCredit(),
  'add_address': (BuildContext context) => const AddAddressPage(),
  'notifications': (BuildContext context) => const NotificationsPage(),
  'edit_password': (BuildContext context) => const EditPasswordPage(),
};

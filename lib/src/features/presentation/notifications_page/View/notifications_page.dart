import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
//Components
import 'package:easy_solutions/src/features/presentation/notifications_page/View/Components/empty_notifications_view.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final bool emptyNotificationsState = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Notificaciones', fontsize: 20.0),
        centerTitle: true,
      ),
      body: emptyNotificationsState
          ? const EmptyNotificationsView()
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([]),
                )
              ],
            ),
    ));
  }
}

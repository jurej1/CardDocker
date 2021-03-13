import 'package:card_docker/pages/home_page/widgets/page_selector.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: const PageSelector(),
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "ProfileRoute")
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

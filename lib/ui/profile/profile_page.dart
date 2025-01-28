import 'package:ecommerce/const/color.dart';
import 'package:ecommerce/data/model/profile_model.dart';
import 'package:ecommerce/data/prefs/current_user.dart';
import 'package:ecommerce/routing/app_router.dart';
import 'package:ecommerce/ui/profile/bloc/profile_bloc.dart';
import 'package:ecommerce/ui/widget/cache_image.dart';
import 'package:ecommerce/ui/widget/common.dart';
import 'package:ecommerce/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage(name: "ProfileRoute")
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel profile = ProfileModel();
  ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    profileBloc.add(FetchProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // Navigation bar
        statusBarColor: Colors.white, // Status bar
      ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        builder: (context, state) {
          return BlocListener<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            listener: (context, state) {
              if (state is ProfileLoaded) {
                profile = state.profile;
              }
            },
            child: Stack(
              children: [
                if (profile.id != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            cacheProfileImage(
                                "https://avatars.githubusercontent.com/u/83339830?v=4",
                                width: 80,
                                height: 80),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${profile.name?.firstname ?? ''} ${profile.name!.lastname ?? ''}"
                                      .capitalize(),
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(profile.email ?? '', style: const TextStyle(fontSize: 18)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Username'),
                        Text(profile.username ?? '', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Phone'),
                        Text(profile.phone ?? '', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Address'),
                        Text(
                          "${profile.address?.street ?? ''}, ${profile.address?.city ?? ''}, "
                          "${profile.address?.zipcode ?? ''}\n",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryLight.withOpacity(0.1),
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _showLogoutConfirmationDialog,
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                if (state is ProfileLoading) ...[circularProgress(true, context)]
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: kPrimaryLight,
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _logout();
    }
  }

  Future<void> _logout() async {
    CurrentUser().logout();
    context.router.replace(LoginRoute());
  }
}

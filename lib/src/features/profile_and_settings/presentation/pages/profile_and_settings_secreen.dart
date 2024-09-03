import 'dart:io';

import 'package:expense_track/src/common/blocs/theme_cubit/theme_cubit.dart';
import 'package:expense_track/src/features/profile_and_settings/presentation/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAndSettingsScreen extends StatefulWidget {
  const ProfileAndSettingsScreen({super.key});

  @override
  State<ProfileAndSettingsScreen> createState() =>
      _ProfileAndSettingsScreenState();
}

class _ProfileAndSettingsScreenState extends State<ProfileAndSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
      ),
      body: BlocProvider(
        create: (context) => PhotoCubit(),
        child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, photoState) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => _uploadPhoto(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: photoState.photoUrl != null
                                ? NetworkImage(photoState.photoUrl!)
                                : null,
                            child: photoState.photoUrl == null
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          ),
                          const Positioned(
                            bottom: 10,
                            right: 10,
                            child: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Edit Profile'),
                  onTap: () {
                    // Navigate to edit profile screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    // Navigate to notifications settings
                  },
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return SwitchListTile(
                      secondary: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      value: themeState.themeMode == AppThemeMode.darkMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().onThemeModeChanged();
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    // context.read<AuthCubit>().logOut();
                    // context.go('/login');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      await context.read<PhotoCubit>().uploadPhoto(File(image.path));
    }
  }
}

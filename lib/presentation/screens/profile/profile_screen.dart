import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/get_user_data/get_user_data_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (!mounted) return;

    BlocProvider.of<GetUserDataBloc>(context).add(GetUserDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile', style: $styles.text.headlineSmall),
        backgroundColor: $styles.theme.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(color: $styles.theme.primaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gap($styles.insets.xs),
                    BlocBuilder<GetUserDataBloc, GetUserDataState>(
                      builder: (_, state) {
                        if (state is GetUserDataLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        } else if (state is GetUserDataSuccess) {
                          return Text(
                            state.user.name,
                            style: $styles.text.headlineSmall,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Account Settings',
                        style: $styles.text.bodyLarge,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Streaming Services',
                        style: $styles.text.bodyLarge,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Notifications Settings',
                        style: $styles.text.bodyLarge,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Blocked Users',
                        style: $styles.text.bodyLarge,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Sharing Settings',
                        style: $styles.text.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

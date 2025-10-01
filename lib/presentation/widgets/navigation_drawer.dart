import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:movieverse/main.dart';
import 'package:movieverse/presentation/bloc/get_user_data/get_user_data_bloc.dart';
import 'package:movieverse/presentation/bloc/logout_user/logout_user_bloc.dart';

import 'drawer_item.dart';

class NavigationsDrawer extends StatefulWidget {
  const NavigationsDrawer({super.key});

  @override
  State<NavigationsDrawer> createState() => _NavigationsDrawerState();
}

class _NavigationsDrawerState extends State<NavigationsDrawer> {
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
    return Drawer(
      backgroundColor: $styles.theme.primaryColor,
      shadowColor: $styles.theme.tertiaryColor,
      surfaceTintColor: $styles.theme.tertiaryColor,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: ListView(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                BlocBuilder<GetUserDataBloc, GetUserDataState>(
                    builder: (_, state) {
                  if (state is GetUserDataLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    );
                  } else if (state is GetUserDataSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.user.name, style: $styles.text.bodyMedium),
                        Gap($styles.insets.xs),
                        Text(state.user.email, style: $styles.text.bodyMedium),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
            Gap($styles.insets.md),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.grey,
            ),
            Gap($styles.insets.md),
            DrawerItem(
              name: 'People',
              icon: Icons.people,
              onPressed: () => {},
            ),
            Gap($styles.insets.sm),
            DrawerItem(
              name: 'Discussion',
              icon: Icons.comment,
              onPressed: () => {},
            ),
            Gap($styles.insets.sm),
            DrawerItem(
              name: 'Ratings',
              icon: Icons.rate_review,
              onPressed: () => {},
            ),
            Gap($styles.insets.sm),
            const Divider(
              thickness: 1,
              height: 10,
              color: Colors.grey,
            ),
            Gap($styles.insets.sm),
            DrawerItem(
              name: 'Setting',
              icon: Icons.settings,
              onPressed: () => {},
            ),
            Gap($styles.insets.sm),
            BlocListener<LogoutUserBloc, LogoutUserState>(
              listenWhen: (_, state) =>
                  state is LogoutLoading ||
                  state is LogoutSuccess ||
                  state is LogoutError,
              listener: (context, state) {
                if (state is LogoutLoading) {
                  const CircularProgressIndicator(
                    color: Colors.blueAccent,
                  );
                } else if (state is LogoutSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logout Success')));
                  context.pushReplacement('/loginScreen');
                } else if (state is LogoutError) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('Logout failed, try again latter'),
                        );
                      });
                }
              },
              child: DrawerItem(
                name: 'Log out',
                icon: Icons.logout,
                onPressed: () =>
                    {context.read<LogoutUserBloc>().add(LogoutRequested())},
              ),
            )
          ],
        ),
      ),
    );
  }
}

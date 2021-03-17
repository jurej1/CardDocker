import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/home_page/widgets/page_selector.dart';
import 'package:card_docker/pages/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  final box = SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final user = state.user;

            return BlocListener<TierStatusBloc, TierStatusState>(
              listener: (context, state) {
                if (state is TierStatusLoadSuccess) {
                  if (state.hasReachedNewTier) {
                    /* 
                      TODO
                      do some dialog that pops up when
                      the user reaches new tier
                    */
                  }
                }
              },
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  ProfilePhoto(imageUrl: user.photoUrl),
                  TierStatusOutput(),
                  box,
                  NameOutput(name: user.displayName),
                  box,
                  LogoutButton(),
                ],
              ),
            );
          } else {
            return Center();
          }
        },
      ),
      bottomNavigationBar: const PageSelector(),
    );
  }
}

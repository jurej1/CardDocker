import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.08;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          height: height,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor,
              ),
              elevation: MaterialStateProperty.all(2.5),
            ),
            onPressed: (state is Loading) ? null : () => BlocProvider.of<AuthBloc>(context).add(LogoutRequested()),
            child: (state is Loading)
                ? const Center(
                    child: const CircularProgressIndicator(),
                  )
                : Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.35,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

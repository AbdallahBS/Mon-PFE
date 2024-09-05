import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/cubit/app_cubits.dart';
import 'package:learn/pages/detaile_page.dart';
import 'package:learn/pages/navpages/main_page.dart';
import 'package:learn/pages/welcome_page.dart';
import 'package:learn/provider/favorites_page.dart';
import '../services/data_services.dart';
import 'app_cubit_states.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubits(data: DataServices()), // Make sure to initialize with actual DataServices
      child: Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
          if (state is WelcomeState) {
            return Home();
          }
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoadedState) {
            return MainPage();
          }
          if (state is DetailState) {
            return DetailPage();
          }
          if(state is FavoriteState){

            return FavoritesPage();
          }
          return Container();
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:learn/cubit/app_cubit_logics.dart';
import 'package:learn/cubit/app_cubits.dart';
import 'package:learn/services/data_services.dart';
import 'model/data_intership_model.dart'; // Import your FavoriteProvider

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DataIntershipModelAdapter()); // Register the adapter
  await Hive.openBox<DataIntershipModel>('favoritesBox'); // Open the box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        BlocProvider<AppCubits>(
          create: (context) => AppCubits(
            data: DataServices(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mon-PFE',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
        AppCubitLogics(),
      ),
    );
  }
}

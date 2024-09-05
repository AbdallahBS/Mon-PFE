import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/provider/favorite_provider.dart';
import 'package:learn/widgets/app_large_text.dart';
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppCubits>(context).goHome();
        return false; // Return false to prevent default behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 8,
          title: const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            // Assuming the favorites are part of the state

            final provider = FavoriteProvider.of(context);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: ListView.builder(
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  final item = provider.favorites[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey[200]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.images.first,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: AppLargeText(
                        text: item.name,
                        size: 18,
                        color: Colors.teal,
                      ),
                      subtitle: Text(
                        item.location,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<AppCubits>(context).detailPage(item);
                      },
                    ),
                  );
                },
              ),
            );

            // Handle other states (Loading, Error, etc.) if necessary
          },
        ),
      ),
    );
  }
}

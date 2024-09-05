import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app_cubit_states.dart';
import '../../cubit/app_cubits.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppCubits>(context).goHome();
        return false; // Return false to prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 8,
          title: const Text(
            'À Propos',
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
            // Handle different states here

              // Build the UI for the loaded state
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // App Logo or Image
                        Center(
                          child: Image.asset(
                            'assets/img/logo.png', // Replace with your app's logo or image
                            height: 100,
                            width: 200,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Title
                        Text(
                          'Mon-PFE',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),

                        // Description
                        Text(
                          'Mon-PFE est une application innovante dédiée à simplifier la recherche de projets de fin d’études dans le secteur des technologies de l’information en Tunisie, en mettant en relation les étudiants avec des entreprises tunisiennes offrant des opportunités intéressantes.',
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.black,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Contact Information
                        Text(
                          "Si vous avez une suggestion ou connaissez une entreprise tunisienne qui propose des projets de fin d’études, n'hésitez pas à me contacter pour ajouter cette entreprise à notre liste. Vous pouvez me joindre à l’adresse suivante :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email : abdallahbenselam@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Footer
                        Center(
                          child: Text(
                            "Je suis ouvert à toutes propositions et collaborations pour enrichir l'application et offrir encore plus d’opportunités aux étudiants.",
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

          },
        ),
      ),
    );
  }
}

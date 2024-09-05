import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/provider/favorite_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learn/cubit/app_cubit_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:learn/misc/colors.dart';
import 'package:learn/widgets/app_buttons.dart';
import 'package:learn/widgets/app_large_text.dart';
import 'package:learn/widgets/responsive_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../cubit/app_cubits.dart';
import '../widgets/app_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = 1;
  int gottenStars = 3;

  // Function to launch the URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppCubits>(context).goHome();
        return false; // Prevent default back action
      },
      child: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        final provider = FavoriteProvider.of(context);
        DetailState detail = state as DetailState;
        final isFavorite = provider.isExist(detail.data); // Check if it's a favorite

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                    ),
                    items: detail.data.images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        child: Image.asset(
                          'assets/img/return.png', // Path to your image
                          width: 24, // Adjust width as needed
                          height: 24, // Adjust height as needed
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 320,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppLargeText(
                                  text: detail.data.name,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.teal,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: AppText(
                                  text: detail.data.location,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          AppLargeText(
                            text: "Description",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          SizedBox(height: 10),
                          AppText(
                            text: detail.data.description,
                            color: AppColors.mainTextColor,
                          ),
                          SizedBox(height: 20),

                          // Add the map here
                          AppLargeText(
                            text: "localisation",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 200,
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(double.parse(detail.data.long), double.parse(detail.data.lat)),
                                zoom: 15.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: LatLng(double.parse(detail.data.long), double.parse(detail.data.lat)),
                                      builder: (ctx) => Container(
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),

                          // LinkedIn URL
                          InkWell(
                            onTap: () => _launchURL(detail.data.linkDin),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/img/linkedin.png', // Replace with your image path
                                  width: 25, // Adjust size if needed
                                  height: 25, // Adjust size if needed
                                ),
                                SizedBox(width: 5), // Add some spacing between the icon and the text
                                Text(
                                  'Profile LinkedIn',
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: () => _launchURL(detail.data.web),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/img/web.png', // Replace with your image path
                                  width: 25, // Adjust size if needed
                                  height: 25, // Adjust size if needed
                                ),
                                SizedBox(width: 5), // Add some spacing between the icon and the text
                                Text(
                                  'Site Web Officiel',
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: () => _launchURL(detail.data.pfeBook2023),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/img/pfe.png', // Replace with your image path
                                  width: 25, // Adjust size if needed
                                  height: 25, // Adjust size if needed
                                ),
                                SizedBox(width: 5), // Add some spacing between the icon and the text
                                Expanded(
                                  child: Text(
                                    'PFE book 2023-2024 (Avoir une Idée)',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          InkWell(
                            onTap: () => _launchURL(detail.data.pfeBook2024),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/img/pfe.png', // Replace with your image path
                                  width: 25, // Adjust size if needed
                                  height: 25, // Adjust size if needed
                                ),
                                SizedBox(width: 5), // Add some spacing between the icon and the text
                                Expanded(
                                  child: Text(
                                    detail.data.pfeBook2024 != null && detail.data.pfeBook2024.isNotEmpty
                                        ? 'PFE Book 2024-2025 (Disponible)'
                                        : 'PFE Book 2024-2025 (En cours)',
                                    style: TextStyle(
                                      color: detail.data.pfeBook2024 != null && detail.data.pfeBook2024.isNotEmpty
                                          ? Colors.teal // Color for available state
                                          : AppColors.mainColor,
                                      decoration: TextDecoration.underline,// Color for "En cours" state
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 200,)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.toggleFavorite(detail.data); // Toggle favorite
                        },
                        child: AppButtons(
                          size: 40,
                          color: isFavorite
                              ? Colors.red
                              : AppColors.textColor1, // Change color if favorite
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor1,
                          isIcon: true,
                          icon: isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border, // Change icon if favorite
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AppCubits>(context).goFavorit();
                        },
                        child: Expanded(
                          child: ResponsiveButton(
                            text: "Consulter les Favoris",
                            height: 40,
                           // width: 290,

                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TileLayerOptions {
}

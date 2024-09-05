import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/cubit/app_cubit_states.dart';
import 'package:learn/widgets/app_large_text.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/app_cubits.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();


    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.teal,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    final double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false; // Return false to prevent default back navigation
      },
      child: Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            if (state is LoadedState) {
              var interships = state.interships.where((item) {
                return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
              }).toList();

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20), // Space for the search bar
                        Container(
                          padding: const EdgeInsets.only(top: 70, left: 20),
                          child: Row(
                            children: [
                              AppLargeText(
                                text: "Liste des entreprises en Tunisie : ",
                                size: 18,
                                color: Colors.teal,
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: interships.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = interships[index];
                                return Container(
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: double.infinity,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "${item.shortdescription}",
                                                style: Theme.of(context).textTheme.bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              ),
                                              const SizedBox(height: 8),
                                              if (item.email != null && item.email!.isNotEmpty)
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/img/gmail.png', // Replace with your image path
                                                      width: 16, // Adjust size if needed
                                                      height: 16, // Adjust size if needed
                                                    ),
                                                    const SizedBox(width: 4), // Space between icon and text
                                                    Text(
                                                      item.email!,
                                                      style: Theme.of(context).textTheme.bodySmall,
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 2),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (item.web != null && item.web!.isNotEmpty)
                                                    InkWell(
                                                      onTap: () {
                                                        _launchURL(item.web!);
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: Image.asset(
                                                          'assets/img/web.png', // Replace with your image path
                                                          width: 16, // Adjust size if needed
                                                          height: 16, // Adjust size if needed
                                                        ),
                                                      ),
                                                    ),
                                                  if (item.linkDin != null && item.linkDin!.isNotEmpty)
                                                    InkWell(
                                                      onTap: () {
                                                        _launchURL(item.linkDin!);
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: Image.asset(
                                                          'assets/img/linkedin.png', // Replace with your image path
                                                          width: 16, // Adjust size if needed
                                                          height: 16, // Adjust size if needed
                                                        ),
                                                      ),
                                                    ),
                                                  TextButton(
                                                    onPressed: () {
                                                      BlocProvider.of<AppCubits>(context).detailPage(interships[index]);
                                                    },
                                                    child: Text("Consulter"),
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                      textStyle: TextStyle(fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.25, // Responsive width
                                          height: screenWidth * 0.25, // Responsive height
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(item.images[0]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.white,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _launchURL(String url) {
    launch(url);
  }
}

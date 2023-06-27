import 'package:flutter/material.dart';
import 'package:mockup_my_screen/pages/options_controller.dart';
import 'package:mockup_my_screen/services/download.dart';
import 'package:mockup_my_screen/services/upload_file.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OptionsController(),
        ),
        Provider(
          create: (context) => UploadService(),
        ),
        Provider(
          create: (context) => DownloadService(),
        ),
      ],
      child: MaterialApp(
        title: 'Mockup My Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: '- My Mockup'),
      ),
    );
  }
}

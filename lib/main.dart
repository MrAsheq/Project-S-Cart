import 'package:flutter/material.dart';
import 'package:project_with_rest_api/screens/home_screen.dart';
import 'package:project_with_rest_api/anotherProjectForPractice/add_new_fruit.dart';

void main(){
  runApp(ProjectRest());
}

class ProjectRest extends StatelessWidget {
  const ProjectRest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Project with RestAPI",
      // home: HomeScreen(),
      home: HomeScreen(),
      theme: ThemeData(
        colorSchemeSeed: Colors.purpleAccent
      ),
    );
  }
}
/// continue again at 9 O'clock
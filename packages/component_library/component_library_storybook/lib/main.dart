import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/provider/devoir_provider.dart';
import 'package:suivi_de_module/provider/test_provider.dart';
import 'stories.dart';

void main() {
  runApp(const StoryApp());
}


class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModuleProvider()),
        ChangeNotifierProvider(create: (_) => DevorProvider()),
        ChangeNotifierProvider(create: (_) => TestProvider())
      ],
      builder: (context, child) => Storybook(stories: [...getStories()]),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/person_list_bloc/person_list_bloc.dart';
import 'package:rick_and_morty_clean/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_clean/features/presentation/pages/home_page.dart';
import 'package:rick_and_morty_clean/service_locator.dart' as di;
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency Injection
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListBloc>(
              create: (context) => sl<PersonListBloc>()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: Colors.amber,
          ),
          home: const HomePage(),
        ));
  }
}

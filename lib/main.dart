import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instagram_clone/core/bloc/add_post_cubit/add_post_cubit.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart';
import 'package:instagram_clone/core/bloc/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/core/bloc/search_cubit/search_cubit.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/get_it_locator/locator.dart';
import 'package:instagram_clone/core/navigation/route_generator.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/theme/dark_theme.dart';
import 'package:instagram_clone/presentation/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await precachePictures();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<LoginCubit>()),
        BlocProvider(create: (context) => getIt.get<SignupCubit>()),
        BlocProvider(create: (context) => getIt.get<HomeCubit>()),
        BlocProvider(create: (context) => getIt.get<AddPostCubit>()),
        BlocProvider(create: (context) => getIt.get<FeedPostCubit>()),
        BlocProvider(create: (context) => getIt.get<CommentsCubit>()),
        BlocProvider(create: (context) => getIt.get<SearchCubit>()),
        BlocProvider(create: (context) => getIt.get<ProfileCubit>())
      ],
      child: AdaptiveTheme(
        initial: AdaptiveThemeMode.dark,
        light: light,
        dark: dark,
        builder: (dark, light) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: light,
            darkTheme: dark,
            supportedLocales: S.delegate.supportedLocales,
            initialRoute: loginRouteName,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}

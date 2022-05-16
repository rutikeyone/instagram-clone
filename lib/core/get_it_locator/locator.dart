import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/service/auth_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  await Firebase.initializeApp();
  getIt.registerSingleton<LoginCubit>(LoginCubit());
  getIt.registerSingleton<Auth>(AuthImpl());
  getIt.registerSingleton<SignupCubit>(SignupCubit(
    auth: getIt.get<Auth>(),
  ));
}

Future<void> precachePictures() async {
  await Future.wait([
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder, 'assets/ic_instagram.svg'),
      null,
    ),
  ]);
}

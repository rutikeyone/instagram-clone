import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/core/bloc/add_post/add_post_cubit.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/service/firestore.dart';
import 'package:instagram_clone/core/service/impl/auth_impl.dart';
import 'package:instagram_clone/core/service/impl/firebase_impl.dart';
import 'package:instagram_clone/core/service/impl/picker_impl.dart';
import 'package:instagram_clone/core/service/impl/storage_impl.dart';
import 'package:instagram_clone/core/service/picker.dart';
import 'package:instagram_clone/core/service/storage.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  await Firebase.initializeApp();

  getIt.registerSingleton<Auth>(AuthImpl());

  getIt.registerSingleton<Picker>(PickerImpl());
  getIt.registerSingleton<Storage>(StorageImpl());
  getIt.registerSingleton<Firestore>(FirestoreImpl(
      storageService: getIt.get<Storage>(),
      firestore: FirebaseFirestore.instance));

  getIt.registerSingleton<LoginCubit>(LoginCubit(
    auth: getIt.get<Auth>(),
  ));
  getIt.registerSingleton<SignupCubit>(SignupCubit(
    auth: getIt.get<Auth>(),
    picker: getIt.get<Picker>(),
    storage: getIt.get<Storage>(),
  ));
  getIt.registerSingleton<HomeCubit>(HomeCubit()..fetchAuthChanges());
  getIt.registerSingleton<AddPostCubit>(
      AddPostCubit(firestoreService: getIt.get<Firestore>()));
  getIt.registerSingleton<FeedPostCubit>(
      FeedPostCubit(firebaseFirestore: FirebaseFirestore.instance)..listen());
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

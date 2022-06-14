// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int pageIndex;
  final model.User user;

  @override
  List<Object> get props => [user, pageIndex];
  const HomeState({required this.user, required this.pageIndex});

  HomeState copyWith({
    int? pageIndex,
    model.User? user,
  }) {
    return HomeState(
      pageIndex: pageIndex ?? this.pageIndex,
      user: user ?? this.user,
    );
  }
}

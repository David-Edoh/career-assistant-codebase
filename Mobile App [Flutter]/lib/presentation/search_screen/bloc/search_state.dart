// ignore_for_file: must_be_immutable

part of 'search_bloc.dart';

/// Represents the state of Search in the application.
class SearchState extends Equatable {
  SearchState({
    this.searchController,
    this.searchModelObj,
    this.users,
    this.posts,
  });

  TextEditingController? searchController;
  List<User>? users;
  List<Post>? posts;
  SearchModel? searchModelObj;

  @override
  List<Object?> get props => [
        searchController,
        searchModelObj,
        users,
        posts,
      ];
  SearchState copyWith({
    TextEditingController? searchController,
    SearchModel? searchModelObj,
    List<User>? users,
    List<Post>? posts,
  }) {
    return SearchState(
      searchController: searchController ?? this.searchController,
      searchModelObj: searchModelObj ?? this.searchModelObj,
      users: users ?? this.users,
      posts: posts ?? this.posts,
    );
  }
}

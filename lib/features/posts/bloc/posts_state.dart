import 'package:blocsync_api_navigator/features/posts/models/post_data_ui_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

abstract class PostActionState extends PostsState {}

class PostFechingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;
  PostFechingSuccessfulState({required this.posts});
}

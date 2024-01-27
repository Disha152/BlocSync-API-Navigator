import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:blocsync_api_navigator/features/posts/bloc/posts_state.dart';
import 'package:blocsync_api_navigator/features/posts/models/post_data_ui_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http; // Import the http package

part 'posts_event.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  Future<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    // Correct parameter types
    var client = http.Client();
    try {
      List<PostDataUiModel> posts = [];
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      print(posts);
      emit(PostFechingSuccessfulState(posts: posts));
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }
}

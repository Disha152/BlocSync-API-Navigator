import 'package:blocsync_api_navigator/features/posts/bloc/posts_bloc.dart';
import 'package:blocsync_api_navigator/features/posts/bloc/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts Page')),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFechingSuccessfulState:
              final successState = state as PostFechingSuccessfulState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(successState.posts[index].title ?? ""),
                    subtitle: Text(successState.posts[index].body ?? ""),
                  );
                },
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

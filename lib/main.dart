import 'package:flutter/material.dart';
import 'api/api_client.dart';
import 'models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIO API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsScreen(),
    );
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ApiClient _apiClient = ApiClient();
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = _apiClient.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts from API'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No posts found');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Post post = snapshot.data![index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    leading: Text(post.id.toString()),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_study/task5/api/github.dart';
import 'package:flutter_study/task5/model/search_result.dart';
import 'package:flutter_study/task5/respository_screen.dart';

class SreachScreen extends StatefulWidget {
  const SreachScreen({super.key});

  @override
  State<SreachScreen> createState() => _SreachScreenState();
}

class _SreachScreenState extends State<SreachScreen> {
  TextEditingController _textEditingController =
      TextEditingController(text: 'HanGuowei/FlutterStudy');

  final _githubApi = GitHubApi();

  final _addFormKey = GlobalKey<FormState>();

  int _currentIndex = 1;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  List<RepositoryItem> listData = [];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: searchFiled(),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                if (index < listData.length) {
                  final list = listData[index];
                  return Material(
                      child: ListTile(
                    title: Text(list.fullName ?? ''),
                    subtitle: Text(list.description ?? ''),
                    onTap: () {
                      _navToRespositoryScreen(listData[index].fullName);
                    },
                  ));
                } else {
                  if (_isLoading) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return null;
                  }
                }
              }),
        ),
      ],
    );
  }

  Widget searchFiled() {
    return Material(
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: searchData,
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  // Widget buildListItem(int index) {
  //   return Material(
  //     child: ListTile(
  //       title: Text(
  //         listData[index].fullName,
  //         style: Theme.of(context).textTheme.titleMedium,
  //       ),
  //       onTap: () {
  //         _navToRespositoryScreen(listData[index].fullName);
  //       },
  //     ),
  //   );
  // }

  Future<void> searchData() async {
    _currentIndex = 1;
    setState(() {
      listData.clear();
      _isLoading = true;
    });
    await _loadMoreData();
    setState(() {
      _isLoading = false;
    });
  }

  void _navToRespositoryScreen(String fullName) {
    Navigator.of(context).push(
      MaterialPageRoute<ResponitoryScreen>(
        builder: (context) => ResponitoryScreen(
          fullName: fullName,
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_isLoading) {
        _isLoading = false;
      } else {
        _isLoading = true;
        _loadMoreData();
      }
    }
  }

  Future<void> _loadMoreData() async {
    final data = await _githubApi.searchRepository(
        _textEditingController.text, _currentIndex, 100);
    // print('-------------data');
    _currentIndex++;
    setState(() {
      listData.addAll(data.items);
    });
  }
}

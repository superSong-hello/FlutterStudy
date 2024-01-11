import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_study/task5/api/github.dart';
import 'package:flutter_study/task5/model/repository_issue.dart';
import 'package:flutter_study/task5/ui_state/load_ui_state_scaffold.dart';
import 'package:flutter_study/task5/ui_state/ui_sate.dart';

class ResponitoryScreen extends StatefulWidget {
  final String fullName;

  const ResponitoryScreen({super.key, required this.fullName});

  @override
  State<ResponitoryScreen> createState() => _ResponitoryScreenState();
}

class _ResponitoryScreenState extends State<ResponitoryScreen> {
  LoadUIState _loadReadmeUIState = Loading();

  final _githubApi = GitHubApi();

  final List<RepositoryIssue> _issues = [];

  bool _isIssuesLoading = true;

  int _currentIssuePage = 1;



  final ScrollController _issuesScrollController = ScrollController();

  @override
  void initState() {
    _issuesScrollController.addListener(_issuesScrollListener);
    _loadReadme();
    _loadMoreIssues();
    super.initState();
  }

  @override
  void dispose()
  {
    _issuesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.fullName),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Readme'),
                Tab(text: 'Issues'),
              ],
            ),
          ),
          body: TabBarView(
            children: [_buildReadme(), _buildIssues()],
          ),
        ));
  }

  Widget _buildReadme() {
    return LoadUIStateScaffold(
      loadUIState: _loadReadmeUIState,
      successBuilder: (data) {
        return Markdown(data: data as String);
      },
    );
  }

  Widget _buildIssues() {
    return Material(
      child: ListView.builder(
          itemCount: _issues.length,
          controller: _issuesScrollController,
          itemBuilder: (context, index) {
            if (index < _issues.length) {
              final issue = _issues[index];
              final isClosed = issue.state == 'closed';
              return ListTile(
                title: Text(
                  issue.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,

                  /// 不自动换行
                ),
                subtitle: Row(
                  children: [
                    isClosed
                        ? const Icon(Icons.circle, color: Colors.purple)
                        : const Icon(Icons.radio_button_checked,
                            color: Colors.green),
                    Expanded(
                        child: Text(
                      issue.body ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ))
                  ],
                ),
              );
            } else {
              if (_isIssuesLoading) {
                return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      ///  是一个用于显示圆形加载指示器的小部件。
                      /// 它通常用于表示正在进行某项异步操作，提供用户反馈。
                      child: CircularProgressIndicator(),
                    ),
                );
              } else {
                return null;
              }
            }
          }),
    );
  }

  Future<void> _loadReadme() async {
    final readmeResult = await _githubApi.getRepositoryReadme(widget.fullName);

    final readmeEncodedContent = readmeResult.content;
    final readmeContent = utf8.decode(
      base64.decode(readmeEncodedContent.replaceAll(RegExp(r'\s'), '')),
    );
    setState(() {
      _loadReadmeUIState = Success(readmeContent);
    });
  }

  Future<void> _loadMoreIssues() async {
    final issueResult =
        await _githubApi.getRepositoryIssue(widget.fullName, _currentIssuePage, 100);
    _currentIssuePage++;
    setState(() {
      _issues.addAll(issueResult);
    });
  }

  void _issuesScrollListener() {
      if(_issuesScrollController.offset>=_issuesScrollController.position.minScrollExtent && !_issuesScrollController.position.outOfRange)
        {
          if(_isIssuesLoading)
            {
              _isIssuesLoading=false;
            }
          else
            {
              _isIssuesLoading=true;
              _loadMoreIssues();
            }
        }
  }
}

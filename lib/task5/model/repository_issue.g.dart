// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryIssueImpl _$$RepositoryIssueImplFromJson(
        Map<String, dynamic> json) =>
    _$RepositoryIssueImpl(
      id: json['id'] as int,
      title: json['title'] as String?,
      body: json['body'] as String?,
      state: json['state'] as String,
      comments: json['comments'] as int,
    );

Map<String, dynamic> _$$RepositoryIssueImplToJson(
        _$RepositoryIssueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'state': instance.state,
      'comments': instance.comments,
    };

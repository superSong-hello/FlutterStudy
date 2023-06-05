import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
class SearchResult with _$SearchResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SearchResult({
    required List<RepositoryItem> items,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
class RepositoryItem with _$RepositoryItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RepositoryItem({
    required int id,
    required String name,
    required String fullName,
    required String? description,
  }) = _RepositoryItem;

  factory RepositoryItem.fromJson(Map<String, dynamic> json) =>
      _$RepositoryItemFromJson(json);
}

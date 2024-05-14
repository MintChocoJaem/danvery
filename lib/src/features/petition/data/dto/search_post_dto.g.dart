// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPostDTO _$SearchPostDTOFromJson(Map<String, dynamic> json) =>
    SearchPostDTO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String? ?? '익명',
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PostFileDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => PostImageDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      views: (json['views'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool? ?? false,
    );

Map<String, dynamic> _$SearchPostDTOToJson(SearchPostDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'views': instance.views,
      'mine': instance.mine,
      'blinded': instance.blinded,
    };

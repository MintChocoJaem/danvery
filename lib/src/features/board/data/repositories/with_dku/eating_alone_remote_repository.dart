import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/eating_alone_post.dart';

final eatingAloneRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => EatingAloneRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class EatingAloneRemoteRepository extends RemoteRepository {
  EatingAloneRemoteRepository({required super.client});

  Future<Board<EatingAlonePost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => EatingAlonePost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<EatingAlonePost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );
    return EatingAlonePost.fromJson(result.data);
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String body,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone',
      method: RequestType.post,
      data: {
        'title': title,
        'body': body,
      },
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone/$id',
      method: RequestType.delete,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> enterPost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone/$id/enter',
      method: RequestType.post,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> closePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone/$id',
      method: RequestType.patch,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<Board<EatingAlonePost>> getUserAppliedBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/with-dankook/eating-alone/my/possible/review',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => EatingAlonePost.fromJson(data as Map<String, dynamic>),
    );
  }
}

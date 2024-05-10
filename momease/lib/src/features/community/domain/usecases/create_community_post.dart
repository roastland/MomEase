import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';

class CreateCommunityPost
    implements UseCase<List<CommunityPostEntity>, CreateCommunityPostParams> {
  final CommunityPostRepository repository;

  CreateCommunityPost(this.repository);

  @override
  Future<Either<Failure, List<CommunityPostEntity>>> call(
      CreateCommunityPostParams params) async {
    return await repository.createCommunityPost(params.communityPost);
  }
}

class CreateCommunityPostParams extends Equatable {
  final CommunityPostEntity communityPost;

  const CreateCommunityPostParams({required this.communityPost});

  @override
  List<Object?> get props => [communityPost];
}

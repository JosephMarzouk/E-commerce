part of 'feed_back_cubit.dart';

@immutable
sealed class FeedBackState {}

final class FeedBackInitial extends FeedBackState {}


final class GetRateLoading extends FeedBackState {}

final class GetRateSuccess extends FeedBackState {}

final class GetRateError extends FeedBackState {}

final class AddOrUpdateRateLoading extends FeedBackState {}
final class AddOrUpdateRateSuccess extends FeedBackState {}
final class AddOrUpdateRateError extends FeedBackState {}

final class AddCommentLoading extends FeedBackState {}
final class AddCommentSuccess extends FeedBackState {}
final class AddCommentError extends FeedBackState {}
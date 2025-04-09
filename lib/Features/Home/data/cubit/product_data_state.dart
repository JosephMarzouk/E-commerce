part of 'product_data_cubit.dart';

@immutable
sealed class ProductDataState {}

final class ProductDataInitial extends ProductDataState {}

final class GetDataLoading extends ProductDataState {}

final class GetDataSuccess extends ProductDataState {}

final class GetDataError extends ProductDataState {}

final class AddToFavoriteLoading extends ProductDataState {}
final class AddToFavoriteSuccess extends ProductDataState {}
final class AddToFavoriteError extends ProductDataState {}
final class RemoveFromFavoriteLoading extends ProductDataState {}
final class RemoveFromFavoriteSuccess extends ProductDataState {}
final class RemoveFromFavoriteError extends ProductDataState {}

final class BuyProductLoading extends ProductDataState {}
final class BuyProductDone extends ProductDataState {}
final class BuyProductError extends ProductDataState {}
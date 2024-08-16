import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/article.dart';
import '../../domain/usecases/get_articles.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticles extends ArticleEvent {
  final List<Article> articles;

  const FetchArticles({required this.articles});

  @override
  List<Object?> get props => [];
}

class ArticlesUpdated extends ArticleEvent {
  final List<Article> articles;

  const ArticlesUpdated(this.articles);

  @override
  List<Object?> get props => [articles];
}

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleLoading extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  const ArticleLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);

  @override
  List<Object?> get props => [message];
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticles getArticles;
  StreamSubscription<List<Article>>? _articlesSubscription;

  ArticleBloc(this.getArticles) : super(ArticleInitial()) {
    on<FetchArticles>((event, emit) async {
      emit(ArticleLoading());
      try {
        final articles = await getArticles();
        emit(ArticleLoaded(articles));
        await _articlesSubscription?.cancel();
        _articlesSubscription = getArticles.repository.articleStream.listen(
          (articles) {
            add(ArticlesUpdated(articles));
          },
          onError: (error) {
            if (state is! ArticleLoaded) {
              emit(const ArticleError('Failed to fetch articles'));
            }
          },
        );
      } catch (_) {
        emit(const ArticleError("Failed to fetch articles"));
      }
    });

    on<ArticlesUpdated>((event, emit) {
      emit(ArticleLoaded(event.articles));
    });
  }

  @override
  Future<void> close() {
    _articlesSubscription?.cancel();
    return super.close();
  }
}

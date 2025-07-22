part of 'lang_cubit.dart';

sealed class LangState extends Equatable {
  const LangState();

  @override
  List<Object> get props => [];
}

final class LangInitial extends LangState {}

final class FirstChooseLangScreenState extends LangState {}

final class ChooseArLangScreenState extends LangState {}

final class ChooseEnLangScreenState extends LangState {}

import 'package:flutter/material.dart';
import 'package:yumzi/data/models/entity/recent_search_entity.dart';
import 'package:yumzi/data/services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  final SearchService _service = SearchService();
  bool _isLoading = false;
  String? _errorMessage;
  RecentSearchEntity? _completedKeyword;
  List<RecentSearchEntity> _recentSearches = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RecentSearchEntity? get completedKeyword => _completedKeyword;
  List<RecentSearchEntity> get recentSearches => _recentSearches;

  Future<RecentSearchEntity?> autoComplete(String keyword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.autoComplete(keyword);
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        _completedKeyword = RecentSearchEntity.fromJson(rootEntity.payload!);
        notifyListeners();
        return _completedKeyword;
      } else {
        _errorMessage = 'Failed to get autocomplete results';
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred while fetching autocomplete results';
      notifyListeners();
      return null;
    }
  }

  Future<List<RecentSearchEntity>> fetchRecentSearches() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final rootEntity = await _service.recentSearches();
      _isLoading = false;
      notifyListeners();

      if (rootEntity.status == 200) {
        _recentSearches = (rootEntity.payload as List)
            .map((item) => RecentSearchEntity.fromJson(item))
            .toList();
        notifyListeners();
        return _recentSearches;
      } else {
        _errorMessage = 'Failed to get recent searches';
        notifyListeners();
        return _recentSearches;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An error occurred while fetching recent searches';
      notifyListeners();
      return _recentSearches;
    }
  }
}

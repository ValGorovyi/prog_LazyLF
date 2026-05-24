class PaginatorLoadResult<T> {
  final List<T> data;
  final int currentPage;
  final int totalPage;
  PaginatorLoadResult({
    required this.data,
    required this.currentPage,
    required this.totalPage,
  });
}

typedef PaginatorLoad<T> = Future<PaginatorLoadResult<T>> Function(int);

class Paginator<T> {
  late int _currentPage;
  late int _totalPage;
  final _data = <T>[];

  List<T> get data => _data;

  var _isLoadingProgres = false;

  final PaginatorLoad<T> load;

  Paginator(this.load);

  Future<void> loadMoviesFromPage() async {
    if (_isLoadingProgres || _currentPage >= _totalPage) return;
    _isLoadingProgres = true;
    final nextPage = _currentPage + 1;

    try {
      final _moviesRes = await load(nextPage);
      _data.addAll(_moviesRes.data);
      _currentPage = _moviesRes.currentPage;
      _totalPage = _moviesRes.totalPage;
      _isLoadingProgres = false;
    } catch (e) {
      //
      _isLoadingProgres = false;
    }
  }

  Future<void> resetCurrentData() async {
    _currentPage = 0;
    _totalPage = 1;
    _data.clear();
    await loadMoviesFromPage();
  }
}

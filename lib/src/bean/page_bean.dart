class PageBean {
  final String className;
  final String routeName;
  final String moduleName;
  final String import;

  PageBean({this.import, this.className, this.routeName, this.moduleName});

  Map<String, dynamic> asMap() {
    final map = <String, dynamic>{};
    void addIfNotNull(String key, dynamic value) {
      if (value != null) {
        map[key] = value;
      }
    }

    addIfNotNull('className', className);
    addIfNotNull('routeName', routeName);
    addIfNotNull('moduleName', moduleName);
    addIfNotNull('path', import);
    return map;
  }
}

abstract class Sorting {
  static sortingMethod(
      {required sortType, required List list, moreData, bool? reversed}) {
    if (sortType == 'sortByKey' && moreData["key"] != null) {
      var key = moreData["key"];
      list.sort((m1, m2) {
        return m1[key]!.compareTo('${m2[key]}');
      });
    }
    if (sortType == 'sortByKeyToSteps' && moreData["key"] != null) {
      var key = moreData["key"];
      list.sort((m1, m2) {
        return m1[key]!.compareTo('${m2[key]}');
      });
    }
    if (reversed != null && reversed == true) {
      return list.reversed.toList();
    } else {
      return list;
    }
  }
}

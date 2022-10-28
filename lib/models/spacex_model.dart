class SpaceX {
  Links? links;
  String? details;
  String? name;
  String? dateLocal;

  SpaceX({
    this.links,
    this.details,
    this.name,
    this.dateLocal,
  });

  SpaceX.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    details = json['details'];
    name = json['name'];
    dateLocal = json['date_local'];
  }
}

class Links {
  Patch? patch;
  String? article;

  Links({
    this.patch,
    this.article,
  });
  
  Links.fromJson(Map<String, dynamic> json) {
    patch = json['patch'] != null ? Patch.fromJson(json['patch']) : null;
    article = json['article'];
  }
}

class Patch {
  String? small;
  String? large;

  Patch({this.small, this.large});

  Patch.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
  }
}

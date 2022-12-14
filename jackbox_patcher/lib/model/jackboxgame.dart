class JackboxGame {
  final String id;
  final String name;
  final String description;
  final String? smallDescription;
  final String background;
  final String latestVersion;
  final String? patchPath;
  final String? path;
  final String? authors;
  final PatchType? patchType;

  JackboxGame({
    required this.id,
    required this.name,
    required this.description,
    required this.background,
    required this.latestVersion,
    required this.patchPath,
    required this.path,
    required this.patchType,
    required this.authors,
    this.smallDescription,
  });

  factory JackboxGame.fromJson(Map<String, dynamic> json) {
    return JackboxGame(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      background: json['background'],
      latestVersion: json['version'],
      patchPath: json['patch_path'],
      path: json['path'],
      patchType: json['patch_type'] == null
          ? null
          : PatchType.fromJson(json['patch_type']),
      authors: json['authors'],
      smallDescription: json['small_description'],
    );
  }
}

class PatchType {
  bool gameText = false;
  bool gameAssets = false;
  bool gameSubtitles = false;
  bool website = false;
  bool audios = false;

  PatchType({
    required this.gameText,
    required this.gameAssets,
    required this.gameSubtitles,
    required this.website,
    required this.audios,
  });

  factory PatchType.fromJson(Map<String, dynamic> json) {
    return PatchType(
      gameText: json['game_text'],
      gameAssets: json['game_assets'],
      gameSubtitles: json['game_subtitles'],
      website: json['website'],
      audios: json['audios'],
    );
  }
}

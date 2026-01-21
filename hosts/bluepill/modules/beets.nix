{pkgs, ...}: let
  ffmpegwithFdkAac = pkgs.ffmpeg.override {
    withFdkAac = true;
    withUnfree = true;
  };
in {
  environment.systemPackages = with pkgs; [
    beets
    ffmpegwithFdkAac
    imagemagick
  ];

  environment.etc."beets/config.yaml".text = ''
    directory: /srv/media/music
    library: /srv/beets/musiclibrary.db

    original_date: yes
    import:
      from_scratch: yes
      languages: en

    plugins: chroma musicbrainz duplicates scrub fetchart embedart lyrics convert mbsync replaygain info
    lyrics:
      sources: lrclib *
    convert:
      auto: yes
      dest: /srv/media/music
      never_convert_lossy_files: yes
      format: aac
      formats:
        aac:
          command: ${ffmpegwithFdkAac}/bin/ffmpeg -i $source -y -vn -c:a libfdk_aac -vbr 5 -ar 44100 $dest
          extension: m4a
        flac:
          command: ${ffmpegwithFdkAac}/bin/ffmpeg -i $source -ar 44100 -sample_fmt s16 -y $dest
          extension: flac
    fetchart:
      cover_format: JPEG
      enforce_ratio: yes
    embedart:
      auto: yes
      maxwidth: 600
      quality: 90
    replaygain:
      backend: ffmpeg
  '';

  environment.variables.BEETS_CONFIG = "/etc/beets/config.yaml";
}

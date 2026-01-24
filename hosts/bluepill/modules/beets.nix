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

  environment.variables.BEETSDIR = "/srv/media/music/beets";

  systemd.tmpfiles.rules = [
    "d /srv/media/music/beets 2775 root share-media -"
  ];

  system.activationScripts.beetsConfig = ''
    mkdir -p /srv/media/music/beets
    chown root:share-media /srv/media/music/beets
    chmod 2775 /srv/media/music/beets

    cat > /srv/media/music/beets/config.yaml <<'EOF'
    directory: /srv/media/music
    library: /srv/media/music/beets/musiclibrary.db

    original_date: yes
    import:
      from_scratch: yes
      languages: en

    plugins: chroma musicbrainz duplicates scrub fetchart embedart lyrics convert replaygain info mbsync
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
    EOF
  '';
}

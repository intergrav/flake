{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [8443];

  services.ollama = {
    enable = true;
    loadModels = ["deepseek-r1:latest" "deepseek-v2:latest" "qwen3-coder:latest" "qwen3-vl:latest" "qwen3:latest" "gemma3:latest" "nemotron-3-nano:latest" "functiongemma:latest" "olmo-3:latest" "gtp-oss:latest" "llama3:latest" "devstral-small-2:latest" "mistral:latest" "mistral-nemo:latest"];
    syncModels = true;
    openFirewall = true;
  };

  virtualisation = {
    docker.enable = true;
    oci-containers = {
      backend = "docker";
      containers.open-webui = {
        image = "ghcr.io/open-webui/open-webui:main";
        extraOptions = ["--network=host"];
        environment = {
          OLLAMA_BASE_URL = "http://127.0.0.1:11434";
        };
        volumes = [
          "/var/lib/open-webui:/app/backend/data"
        ];
        autoStart = true;
      };
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts.":8443".extraConfig = ''
      encode gzip zstd
      reverse_proxy 127.0.0.1:8080
    '';
  };
}

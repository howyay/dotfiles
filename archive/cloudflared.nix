  services.cloudflared = {
    enable = true;
    user = "haoye";
    tunnels = {
      "ce323082-30a6-4903-a017-fe3344bb0f57" = {
        warp-routing.enabled = true;
        default = "http_status:404";
        credentialsFile = "/home/haoye/.cloudflared/ce323082-30a6-4903-a017-fe3344bb0f57.json";
        ingress = {
          "mc.haoye.red"= "tcp://localhost:25565";
        };
      };
    };
  };

listen {
  port = 9110
  address = "nginx_exporter"
  metrics_endpoint = "/metrics"
}

namespace "app" {
  source {
    files = [
      "/mnt/nginxlogs/access.log"
    ]
  }

  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\""
  
  relabel "request" {
    from = "request"
  }

  relabel "status" {
    from = "status"
  }

  relabel "remote_addr" {
    from = "remote_addr"
  }

  relabel "remote_user" {
    from = "remote_user"
  }

  relabel "time_local" {
    from = "time_local"
  }

  relabel "http_referer" {
    from = "http_referer"
  }

  relabel "path" {
    from = "request"
    split = 2
    separator = " "

    match "^/static/.*" {
      replacement = "/static/..."
    }

    match "(^/.*)" {
      replacement = "$1"
    }
  }


}

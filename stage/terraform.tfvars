target_region = "ap-northeast-1"

tags = {
  env     = "test"
  service = "static"
  version = 0.3
  project = "11141010"
}

fqdn = {
  www = "www.veriws.net"
}

athena = {
  # database name must be lowercase letters, numbers or '_'.
  database_name = "images_access_log"
}

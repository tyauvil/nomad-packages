server {
    enabled = true
    bootstrap_expect = 1
}

client {
    enabled = true
    servers = ["127.0.0.1"]
    options = {
        "driver.raw_exec.enable" = "1"
    }
}

data_dir  = "/var/lib/nomad"

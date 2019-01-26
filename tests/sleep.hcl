job "docs" {
    datacenters = ["dc1"]

        group "example" {

        task "server" {
            driver = "raw_exec"
            config {
                command = "/bin/sleep"
                args    = ["600"]
            }

            resources {
                cpu = 20
            }
        }
    }
}

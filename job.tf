provider "nomad" {
  address = "https://server.global.nomad:4646"
  ca_file = "nomad-ca.pem"
  cert_file = "cli_cert_file.pem"
  key_file = "cli_key.pem"
}

# Register a job
resource "nomad_job" "monitoring" {
  jobspec = "${file("example.nomad")}"
}

resource "tls_private_key" "global_nomad_cli" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "global_nomad_cli" {
  key_algorithm   = "${tls_private_key.global_nomad_cli.algorithm}"
  private_key_pem = "${tls_private_key.global_nomad_cli.private_key_pem}"

  subject {
    common_name = "cli"
    organization = "Example, Inc"
    organizational_unit = "Tech Ops Dept"
  }
}

resource "tls_locally_signed_cert" "global_nomad_cli" {
  cert_request_pem = "${tls_cert_request.global_nomad_cli.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["cli_auth"]
}
resource "local_file" "cli_key" {
    content = "${tls_private_key.global_nomad_cli.private_key_pem}"
    filename = "cli_key.pem"
}
resource "local_file" "cli_cert" {
    content     = "${tls_locally_signed_cert.global_nomad_cli.cert_pem}"
    filename = "cli_cert_file.pem"
}



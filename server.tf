resource "tls_private_key" "global_nomad_server" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "global_nomad_server" {
  key_algorithm   = "${tls_private_key.global_nomad_server.algorithm}"
  private_key_pem = "${tls_private_key.global_nomad_server.private_key_pem}"

  subject {
    common_name = "server.global.nomad"
    organization = "Example, Inc"
    organizational_unit = "Tech Ops Dept"
  }
}

resource "tls_locally_signed_cert" "global_nomad_server" {
  cert_request_pem = "${tls_cert_request.global_nomad_server.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["server_auth"]
}
resource "local_file" "server_key" {
    content = "${tls_private_key.global_nomad_server.private_key_pem}"
    filename = "server_key.pem"
}
resource "local_file" "server_cert" {
    content     = "${tls_locally_signed_cert.global_nomad_server.cert_pem}"
    filename = "server_cert_file.pem"
}



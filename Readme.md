Example files for deploying full tls-authenticated nomad client/server/cli using terraform PKI.
Next steps: 
- [ ] Provision consul for name resolution.
- [ ] Use null resources with provisioning to set up nomad servers and clients.
- [ ] Modularize/parameterize in such a way as to have a simple list of consul & nomad servers and nomad clients, and pass in a set of ips/credentials as tfvars or similar.

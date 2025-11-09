# terraform-jissen-iac

## 事前準備

```console
$ cd ./bootstrap
$ terraform init
$ terraform plan
$ terraform apply
```

## dev環境の構築

```console
$ terraform init -backend-config=backend/backend.tfvars
$ terraform plan -var-file=env/dev.tfvars
$ terraform apply -var-file=env/dev.tfvars
```

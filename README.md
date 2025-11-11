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
$ terraform workspace new dev
```

すでにdevワークスペースを作成している場合
```console
$ terraform workspace select dev
```

```console
$ terraform init
$ terraform plan
$ terraform apply
```

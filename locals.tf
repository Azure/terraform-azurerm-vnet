locals {
  subnet_names_prefixes = zipmap(var.subnet_names, var.subnet_prefixes)
}
variable "password" {
    default = "supersecert@pswd"
    sensitive = true
  
}

resource "local_file" "foo" {
    content = var.password
    filename = "password.txt"
  
}


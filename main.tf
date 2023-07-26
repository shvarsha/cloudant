resource null_resource "test" {

    provisioner "local-exec" {
    command = <<EOT
      curl google.com
    EOT
    }
  
}

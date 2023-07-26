resource null_resource "test" {

    provisioner "local-exec" {
    command = <<EOT
      curl google.com
      curl -s 'https://api.github.com/users/lambda' | jq -r '.name'
    EOT
    }
  
}

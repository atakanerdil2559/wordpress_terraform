WIP
# Wordpress with Terraform

Terraform AWS Template

 ## Prerequisites:
   - AWS account
   - Terraform installed 
   - SSL Certificate
   - SSH key
   - Domain Name
   
## Usage

## Resources

## Useful Links

[terraform modules](https://registry.terraform.io/modules/erkinsinc/wordpress/aws/latest?tab=resources)

[wordpress with terraform and ansible](https://mschirbel.medium.com/wordpress-on-aws-using-terraform-and-ansible-8c3e04cb76e9)

[for each](https://learn.hashicorp.com/tutorials/terraform/for-each?in=terraform/configuration-language)

# this resource blocks generated keys and stores it in state file,
# it is not a good practice to pass around a private key but for temporary dev environment where you 
# don't need to pass the key is ok.
# create script for ssh-keygen, import the key to aws console, use ansible
# key_name      = aws_key_pair.generated_key.key_name
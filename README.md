# Mini-Project Documentation

## 1. Introduction

Blackpearl project is a mini project in the AltSchool Cloud engineering V2 program. The project uses terraform to create 3 EC2 instances and puts them behind an Elastic load balancer (Application load balancer), the project requires the terraform script after application to export the public IP addresses of the 3 EC2 instances to a file called `host-inventory` which is used by ansible to configure the EC2 instances. The ansible playbook installs and configures Apache2 web server on the EC2 instances and also creates a default `index.html` file on the web server, it also changes the timezone to Africa/Lagos on the Apache2 web server, the hostname, IP address and the timezone are displayed on the web server's default page. A `.com.ng` domain name was purchased from [Qserver](https://www.qservers.net) and the DNS records were configured to point to the Elastic load balancer. The project also uses a bash script to automate the deployment of the application.
the project is successfully deployed when terraform-test.domain name is entered in a web browser and the web page displays the hostname, IP address and the timezone of the EC2 instances.

## 2. Requirements

- Terraform installed on your local machine
- Ansible installed on your local machine
- AWS CLI installed on your local machine
- AWS account
- Qserver account or any other domain name registrar
- A domain name.

## 3. Usage

- Clone the repository to your local machine

- Create a file called `terraform.tfvars` in the `blackpearl-project` directory and add the values for the following variables to the file:

```bash
region=""
profile=""
cidr_block=""
project-name=""
instance_type=""
domain-name=""
subdomain-name=""
```

- Go to the backend.tf file and change the bucket name to a unique name and also change other values if necessary.

- Navigate to the `ansible` directory and edit the paths to the private key and the `host-inventory` file in the `ansible.cfg` file.

- Navigate to the blackpearl-project directory and edit the paths to directories appropriately in the `apply.sh` and `destroy.sh` files and ensure make both files executable by running the following commands:

```bash
chmod +x apply.sh
chmod +x destroy.sh
```

- Initialize terraform by running the following command:

```bash
terraform init
```

- Check for errors by running the following command:

```bash
terraform validate
```

- Check for changes by running the following command:

```bash
terraform plan
```

- Run the `apply.sh` file to deploy the application and run the `destroy.sh` file to destroy the application.

- After the application has been deployed, enter the domain name in a web browser to view the web page.

## 4. Directory Structure

```bash
├── ansible
│   ├── ansible.cfg
│   ├── apache2.yml
│   ├── host-inventory.ini
│   ├── index.html.j2
│   └── server-info.php.j2
├── blackpearl-project
│   ├── .gitignore
│   ├── apply.sh
│   ├── backend.tf
│   ├── destroy.sh
│   ├── main.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── modules
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── elb 
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── sg 
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── README.md
```

## 4. Author

- [Hamed Ayodeji](https://github.com/Hamed-Ayodeji)

## 5. License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 6. Acknowledgements

- [AltSchool](thealtschool.com)
- [Qserver](https://www.qservers.net)
- [AWS](https://aws.amazon.com)
- [Terraform](https://www.terraform.io)
- [Ansible](https://www.ansible.com)

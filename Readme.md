# Minimal Flask on Azure Functions setup with Terraform

Requires:
- Azure CLI, Azure Functions Core Tools, Terraform, Python 3.9

Steps to run:
- Within a Python 3.9 environment run `pip install -r requirements.txt`
- Create `local.settings` e.g. by copying `sample.local.settings`. 
- Start the app with `func start`
- Visit <http://localhost:7071>.

Steps to deploy:
- Login with Azure CLI
- In `/terraform` configure variables `prefix` and `location` as hinted in `sample.main.tfvars` and run `terraform apply`. This will create a function app called `<prefix>`.
- Deploy the function via `func azure functionapp publish <chosen prefix>`.
- Visit `http://<prefix>.azurewebsites.net`
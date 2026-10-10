# Terraform-GCP

**Main Application Repository:** [https://github.com/pietro-foini/agentic-chatbot](https://github.com/pietro-foini/agentic-chatbot)

Infrastructure as Code (IaC) repository using Terraform to deploy cloud resources on Google Cloud Platform (GCP).

The infrastructure is split into components (`common`, `chatbot`) and uses environment-based configuration files (`environments/<env>/`).


## Repository Structure

- **terraform/common**: Shared baseline resources (Artifact Registry, Cloud SQL instance, IAM, shared secrets).
- **terraform/chatbot**: Chatbot specific resources (Cloud Run, Cloud Build, app secrets, GCS buckets).
- **environments/**: Variable definitions per environment (each corresponding to a GCP project in my case).

> **Note:** Separating `common` was technically redundant for this scope, but it was designed this way to simulate a 
> scalable architecture where additional components can easily be added in the future.

## Prerequisites & Local Setup

An active Google Cloud Platform project with billing enabled and sufficient IAM permissions (e.g., Owner or Editor).

1. Tools required
   - **Terraform** (https://developer.hashicorp.com/terraform/install):
   
      > terraform -version 

   - **Google Cloud SDK** (https://cloud.google.com/sdk/docs/install). 
   - **Python & pip** for pre-commit hooks (optional).

2. Configure pre-commit for code formatting (optional):

    > pip install pre-commit  
    > pre-commit install
  
3. Local GCP Authentication:

    Terraform uses Application Default Credentials when running locally:
    
    > gcloud auth application-default login

## Deployment

### Step 1: Pre-Deployment Setup (Manual)

Before running Terraform with remote state, complete these initial manual steps:

1. Create the Terraform State GCS Bucket:

    Terraform needs a remote bucket to store state files:
    
        gcloud storage buckets create gs://<YOUR-TFSTATE-BUCKET-NAME> \
          --project="<YOUR-PROJECT-ID>" \
          --location="<YOUR-REGION>" \
          --uniform-bucket-level-access
    
    (It is strongly recommended to enable object versioning on this bucket).
    
    In my case, I have `<YOUR-PROJECT-ID>=foini-506814` and `<YOUR-REGION>=europe-west1`; and I set 
    `<YOUR-TFSTATE-BUCKET-NAME>=foini-506814-tf-state`.
    
    Or create the bucket through GCP Console.

2. Connect GitHub to GCP Developer Connect:

   - Open GCP Console.
   - Navigate to Developer Connect > Connections > Create connection.
   - Connect your GitHub repositories that you need for the current implementation. In my case, the current one and the 
   application repository linked at the start.

### Step 2: Deployment Workflow

Deploy `common` first, followed by `chatbot`.

#### Deploy `common`

Navigate to directory:

    cd terraform/common

Initialize with remote backend:

    terraform init `
      -backend-config="bucket=foini-506814-chatbot" `
      -backend-config="prefix=environments/foini/common" `
      -migrate-state

Validate configuration:

    terraform validate

Run plan:

    terraform plan -var-file="../../environments/foini/common.tfvars"

Apply changes:

    terraform apply -var-file="../../environments/foini/common.tfvars"

#### Deploy `chatbot`

Navigate to directory:

    cd terraform/chatbot

Initialize remote backend:

    terraform init `
      -backend-config="bucket=foini-506814-chatbot" `
      -backend-config="prefix=environments/foini/chatbot" `
      -migrate-state

Validate configuration:

    terraform validate

Run plan:

    terraform plan -var-file="../../environments/foini/chatbot.tfvars"

Apply changes:

    terraform apply -var-file="../../environments/foini/chatbot.tfvars"

### Step 3: Post-Deployment Steps (Manual)

Once the infrastructure resources are provisioned by Terraform:

- Enable `pgvector` on Cloud SQL: 
  - Go to CloudSQL in the GCP Console.
  - Connect to the created database.
  - Run the following SQL statement:

    > CREATE EXTENSION IF NOT EXISTS vector;
  
- Set Secret Values: Terraform creates the secret containers in Secret Manager (secrets.tf). Add the real secret 
payload/value manually:

  - Go to Secret Manager in the GCP Console.
  - Select the created secret (`auth_key`).
  - Click Add new version and paste the actual secret key.

---

### Optional: Testing Locally without GCS Backend

If you want to test syntax and plan purely locally without touching the remote GCS state:

Open `backend.tf` and temporarily comment out the backend block and follow previous initialization, validation, planning and
applying steps.

Terraform will automatically fall back to the default `local` backend. If you run terraform apply, it will store the state
locally in a file named `terraform.tfstate` inside the current folder (make sure `.tfstate` files are included in your 
`.gitignore` so they are not committed to Git).

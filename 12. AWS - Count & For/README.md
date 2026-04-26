# 12. AWS - Count & For

This example shows how **`count`** creates one resource per list element and how **`for` expressions** and the **splat operator** `[*]` shape outputs into lists and maps—without repeating blocks by hand.

## What it creates

- **`aws_iam_user.user`**: one IAM user per entry in **`var.user_names`** (`count = length(var.user_names)`), each **`name`** taken with **`element(var.user_names, count.index)`** (equivalent to **`var.user_names[count.index]`** in modern Terraform).
- **`aws_instance.servers`**: the same number of **`t3.micro`** EC2 instances in **`eu-central-1`**, each tagged **`Name = "Server ${count.index + 1}"`** (human-friendly numbering from 1).

Default users: **`tony`**, **`steve`**, **`thor`**, **`wanda`**, **`vision`** — so by default you get **5** users and **5** instances.

## Outputs (`outputs.tf`)

| Output | Idea |
|--------|------|
| **`user_names`** | Splat: **`aws_iam_user.user[*].name`** — flat list of all user names. |
| **`user_arns`** | `for` over resources → list of strings with name + ARN. |
| **`user_names_and_arns`** | `for` → **map** (`name => arn`). |
| **`user_has_5_characters_or_more`** | `for` with **`if`** — only users whose **`name`** has length **≥ 5**. |
| **`servers_ips`** | Splat: public IPs of all instances. |
| **`server_map_ips`** | `for` over instances → map **`tags.Name` → `public_ip`**. |

## Variables (`variables.tf`)

| Variable | Role |
|----------|------|
| **`user_names`** | `list(string)` — drives **`count`** for both IAM users and EC2 instances. |

## How to run

```bash
cd "12. AWS - Count & For"
terraform init
terraform plan
terraform apply
```

Use fewer users/instances without editing `variables.tf`:

```bash
terraform apply -var='user_names=["alice","bob"]'
```

## How to destroy

```bash
terraform destroy
```

## Notes / safety

- **EC2 instances cost money**; IAM users are effectively free. Run **`terraform destroy`** when you are done.
- The AMI id in **`main.tf`** is fixed for **`eu-central-1`**; change it if you use another region.

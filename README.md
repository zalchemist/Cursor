# Cursor

Cursor application repository.

## Deploy Key Setup

This repository uses an SSH deploy key for automated deployments via GitHub Actions.

### Generating the deploy key

Run the following command to generate a new SSH key pair:

```bash
ssh-keygen -t ed25519 -C "cursor-deploy-key" -f cursor_deploy_key -N ""
```

This creates two files:
- `cursor_deploy_key` — private key (keep this secret, never commit it)
- `cursor_deploy_key.pub` — public key (added to GitHub as a deploy key)

### Adding the public key to GitHub

1. Go to **Settings → Deploy keys** in this repository.
2. Click **Add deploy key**.
3. Paste the contents of `cursor_deploy_key.pub`.
4. Select **Allow write access** only if the deployment process needs to push commits.
5. Click **Add key**.

### Storing the private key as a GitHub secret

1. Go to **Settings → Secrets and variables → Actions** in this repository.
2. Click **New repository secret**.
3. Set the name to `DEPLOY_KEY`.
4. Paste the contents of `cursor_deploy_key` as the value.
5. Click **Add secret**.

### Triggering a deployment

Deployments run automatically on every push to the `main` branch, or can be triggered manually from the **Actions** tab using the **Deploy** workflow.

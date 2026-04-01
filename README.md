# Cursor
Cursor

## Make Repositories Private

The **Make Repositories Private** workflow lets you change repository visibility to private
so your repositories are no longer publicly visible.

### Setup

1. Create a [Personal Access Token (classic)](https://github.com/settings/tokens/new) with the **`repo`** scope.
2. Add the token as a repository secret named **`REPO_VISIBILITY_TOKEN`**:
   - Go to **Settings → Secrets and variables → Actions → New repository secret**
   - Name: `REPO_VISIBILITY_TOKEN`
   - Value: your Personal Access Token

### Usage

Go to **Actions → Make Repositories Private → Run workflow**.

| Input | Description | Default |
|-------|-------------|---------|
| `repository` | Repository name to make private (e.g. `MyRepo`). Leave empty to target **all** public repositories. | *(empty — all repos)* |
| `dry_run` | If `true`, lists what would change without making any changes. | `true` |

> **Tip:** Always do a dry run first to review which repositories will be affected before setting `dry_run` to `false`.

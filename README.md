# HPCI Homebrew Tap

## Available formulae

- [`hpcissh`](https://github.com/hpci-auth/hpcissh-clients)
- [`jwt-agent`](https://github.com/oss-tsukuba/jwt-agent)
- [`oidc-agent-cli@5`](https://github.com/indigo-dc/oidc-agent) (without `oidc-prompt`; for development only, not used in HPCI operations)

## For users

Add this tap:

```sh
brew tap hpci-auth/tap
```

Trust the formula before installing it:

```sh
brew trust --formula hpci-auth/tap/FORMULA_NAME
```

Replace `FORMULA_NAME` with the formula name, such as `hpcissh`.

Install a formula:

```sh
brew install FORMULA_NAME
```

For example:

```sh
brew install hpcissh
```

Uninstall a formula:

```sh
brew uninstall FORMULA_NAME
```

To remove the tap:

```sh
brew untap hpci-auth/tap
```

## For developers

### Test formulae locally before pushing

Before running the check script, untap the production tap:

```sh
brew untap hpci-auth/tap
```

Set the local test tap path and run the check script:

```sh
REPOSITORY="$(brew --repo hpci-auth/tap-localtest)"

./check-before-push.sh [FORMULA_NAME]
```

The script registers the current directory as a local tap by creating a symlink at `${REPOSITORY}`. It then installs, tests, and uninstalls every formula, or only the specified formula if you provide one. It removes the tap's trust when the script exits, including after a failure.

Remove the local test tap symlink when you are done:

```sh
rm "${REPOSITORY}"
```

### Release

See [Homebrew Tap with bottles uploaded to GitHub Releases](https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/) for background.

1. Create a branch, update the formula files, and push the branch:

   Update fields such as `tag`, `revision`, and `version` in the formula files. You do not need to edit the `root_url` and `sha256` lines; they are populated automatically.

   ```sh
   git checkout -b BRANCH_NAME
   # Edit the formula files
   git add <file name...>
   git commit
   git push origin BRANCH_NAME
   ```

2. In the GitHub web interface, create a new pull request from your branch to `main`.
3. Wait for the pull request checks to pass, then add the `pr-pull` label.
4. After a few minutes, the pull request will close automatically, the bottles will be uploaded, and the commits will be pushed to `main`.

### GitHub Actions Runner

If a GitHub Actions runner changes or is retired, check the [GitHub-hosted runners documentation](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#standard-github-hosted-runners-for-public-repositories) and update the runner matrix in `.github/workflows/tests.yml`.

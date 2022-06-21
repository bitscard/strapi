## Release to production
Deployment is automated using GitHub Actions and is triggered using `latest` tag. 

For convenience there is a shell script (`production-release.sh`) that automates the steps below, but only use it if you're 100% you know what you're doing. 

Follow the steps below to release to production manually. Examples assume our GitHub repo remote is called `origin` and that the changes are already merged into `main`.

1. Check out `main` branch (optionally: check out the commit you want to deploy if it's not the tip of `main` branch)
2. Add version tag (should be already updated in package.json):  
`git tag -a v1.3.4 -m "Release v1.3.4"`
3. Remove existing `latest` tag from GitHub:  
`git push origin :refs/tags/latest`
4. Add `latest` tag:  
`git tag -fa latest -m "Release v1.3.4"`
5. Push tags to GitHub to trigger deployment to Production:  
`git push origin main --tags`
6. Monitor deployment in GitHub Actions workflow run, validate application was successfully deployed.

## Rollback to previous version
In case something is critically broken in production and producing a hotfix is not viable, roll back to previous stable version. For example if release of version `v1.3.4` broke the app, but `v1.3.3` was working fine, follow this procedure:

1. Check out the latest stable version, e.g.:  
  `git checkout v1.3.3`
2. Remove existing `latest` tag from GitHub:  
   `git push origin :refs/tags/latest`
3. Add `latest` tag:  
   `git tag -fa latest -m "Rollback to v1.3.3"`
4. Push tags to GitHub to trigger deployment to Production:  
   `git push origin main --tags`
5. Monitor deployment in GitHub Actions workflow run, validate application was successfully deployed.

# deis-workflow-cli-docker

This alpine Linux based Docker image packages the Deis Workflow CLI for use in CI and other automated environments.

It supports three methods for automatic login:

* Set DEIS_USERNAME, DEIS_TOKEN and DEIS_CONTROLLER (generates a deis profile)
* Set DEIS_USERNAME, DEIS_PASSWORD and DEIS_CONTROLLER (logs in using `deis login`)
* Mount an existing profile directory to /root/.deis in the container

You can also set DEIS_SSH_KEY or SSH_KEY to a private key used for Deis Builder git push.
The key will be loaded into the ssh-agent automatically, so it must be unencrypted.

Example of running manually:

```sh
docker run --rm -it \
  -e DEIS_USERNAME=ci \
  -e DEIS_PASSWORD=secret \
  -e DEIS_CONTROLLER=https://deis.example.org \
  -e SSH_KEY="$(cat ~/.ssh/id_rsa)" \
  felixbuenemann/deis-workflow-cli:v2.7.0 \
  deis apps
```

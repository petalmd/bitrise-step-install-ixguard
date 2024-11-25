# Install iXGuard

Install Guardsquare and iXGuard cli tools.

<details>
<summary>Description</summary>

Downloads and installs guardsquare and ixguard in order to process and protect an archive. If the correct version of iXGuard is already detected, the download will be skipped.

### Configuring the Step

To be able to use the Step, you need to create and register an ssh key to grant permission to Guardsquare.

1. Create key pair using `ssh-keygen`.
2. Create a secure passphrase for your private key.
3. Upload the public key `.pub` to your Guardsquare account.
4. Upload the private key file to the **Files** secion of your Bitrise project.
5. Create a **Secret Env Variable** for the private key passphrase (make sure to escape any special characters with a `\` before saving).
6. If your file download URL or Secret Env Variable does not correspond with the defaults, make sure you list them as inputs to the Step.

</details>

## 🧩 Get started

Add this step directly to your workflow in the [Bitrise Workflow Editor](https://devcenter.bitrise.io/steps-and-workflows/steps-and-workflows-index/).

You can also run this step directly with [Bitrise CLI](https://github.com/bitrise-io/bitrise).

### Example

Download and install iXGuard version 4.12.2 to your workflow.

```yaml
workflows:
  deploy:
    steps:
      - git::https://github.com/npinney/bitrise-step-install-ixguard.git@main:
          inputs:
            - version: "4.12.2"
```

## ⚙️ Configuration

<details>
<summary>Inputs</summary>

| Key | Description | Flags | Default |
| --- | --- | --- | --- |
| `version` | Default is 4.12.6. If a different version is detected, the Step will install the correct version. | | `$IXGUARD_VERSION` |
| `ssh_key_file` | Private key download link to grant access to Guardsquare.  | | `$BITRISEIO_GUARDSQUARE_SSH_KEY_FILE_URL` |
| `ssh_key_passphrase` | Passphrase used to decrypt the ssh private key. Make sure special symbols have been escaped. | | `$GUARDSQUARE_SSH_KEY_PASSPHRASE` |

</details>

<details>
<summary>Outputs</summary>

There are no outputs defined in this step

</details>

Learn more about developing steps:

- [Create your own step](https://devcenter.bitrise.io/contributors/create-your-own-step/)
- [Testing your Step](https://devcenter.bitrise.io/contributors/testing-and-versioning-your-steps/)

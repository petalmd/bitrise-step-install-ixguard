# Install iXGuard

Install Guardsquare and iXGuard cli tools.

<details>
<summary>Description</summary>

Downloads and installs guardsquare and ixguard in order to process and protect an archive. If the correct version of iXGuard is already detected, the download will be skipped.

### Configuring the Step

By default, the Step requires no configuration. To be able to use it, you only need to you have an ssh key registered with Guardsquare added to the local SSH agent. In bitrise, this can be done with the [Certificate and profile install](https://github.com/bitrise-steplib/steps-certificate-and-profile-installer) provided the private key was uploaded to bitrise.

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
      - certificate-and-profile-installer@1: {}
      - git::git@github.com:npinney/bitrise-step-install-ixguard.git:
          inputs:
            - version: "4.12.2"
```

## ⚙️ Configuration

<details>
<summary>Inputs</summary>

| Key | Description | Flags | Default |
| --- | --- | --- | --- |
| `version` | Default is 4.12.6. If a different version is detected, the Step will install the correct version. | | `$IXGUARD_VERSION` |

</details>

<details>
<summary>Outputs</summary>

There are no outputs defined in this step

</details>

Learn more about developing steps:

- [Create your own step](https://devcenter.bitrise.io/contributors/create-your-own-step/)
- [Testing your Step](https://devcenter.bitrise.io/contributors/testing-and-versioning-your-steps/)

# Beacon

## TL;DR

```console
helm repo add nbis https://nbisweden.github.io/beacon-helm
helm install my-release nbis/beacon
```

## Parameters

### Config Parameters

| Name                    | Description                                   | Value   |
| ----------------------- | --------------------------------------------- | ------- |
| `config.debug`          | Enable logging in debug mode                  | `false` |
| `config.ini`            | Beacon information including OAuth2 config    | `""`    |
| `config.publicKey.data` | Public key, armored, for validating the token | `""`    |

### Database Parameters

| Name                       | Description                     | Value    |
| -------------------------- | ------------------------------- | -------- |
| `externalDatabase.host`    | External Database server host   | `""`     |
| `externalDatabase.name`    | External Database database name | `beacon` |
| `externalDatabase.user`    | External Database username      | `""`     |
| `externalDatabase.pasword` | External Database user password | `""`     |
| `externalDatabase.port`    | External Database server port   | `5432`   |

### Beacon Image Parameters

| Name               | Description              | Value                 |
| ------------------ | ------------------------ | --------------------- |
| `image.repository` | Beacon image repository  | `cscfi/beacon-python` |
| `image.tag`        | Beacon image tag         | `latest`              |
| `image.pullPolicy` | Beacon image pull policy | `IfNotPresent`        |

### Beacon Ingress Parameters

| Name                  | Description                                                | Value   |
| --------------------- | ---------------------------------------------------------- | ------- |
| `ingress.annotations` | Additional annotations for the Ingress resource            | `{}`    |
| `ingress.hostName`    | Default host for the ingress record                        | `""`    |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress | `nginx` |
| `ingress.issuer`      | Cert-manager configured issuer                             | `""`    |
| `ingress.useTLS`      | Enable TLS configuration for the host                      | `false` |
| `ingress.secretName`  | Custom TLS certificates as secrets                         | `""`    |

### Beacon Persistence Parameters

| Name                        | Description                                        | Value   |
| --------------------------- | -------------------------------------------------- | ------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims  | `false` |
| `persistence.storageSize`   | Persistent Volume size                             | `20Gi`  |
| `persistence.storageClass`  | Persistent Volume storage class                    | `""`    |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`    |

### Beacon Resource Parameters

| Name                 | Description                                   | Value |
| -------------------- | --------------------------------------------- | ----- |
| `resources.requests` | The requested resources for the Beacon server | `{}`  |
| `resources.limits`   | The resources limits for the Beacon server    | `{}`  |

### Beacon Security Parameters

| Name                          | Description                                     | Value   |
| ----------------------------- | ----------------------------------------------- | ------- |
| `security.createPolicy`       | Create a security policy for the Beacon server  | `false` |
| `security.fsGroup`            | Set the Beacon pod's Security Context fsGroup   | `1000`  |
| `security.RunAsUser`          | Set the Beacon pod's Security Context runAsUser | `1000`  |
| `security.serviceAccountName` | name of an existing ServiceAccount to use       | `""`    |

Specify each parameter using the --set key=value[,key=value] argument to helm install. For example,

```console
helm install my-release \
  --set externalDatabase.user=admin \
  --set externalDatabase.assword=password \
  --set externalDatabase.host=postgres.svc \
    nbis/beacon
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml nbis/beacon
```

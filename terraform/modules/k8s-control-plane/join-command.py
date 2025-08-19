import os
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

keyVaultName = "cluster-kv"
KVUri = f"https://cluster-kv.vault.azure.net"

credential = DefaultAzureCredential()
client = SecretClient(vault_url=KVUri, credential=credential)

secretName = "join"
secretValue = "echo 'Join'"

print(f"Creating a secret in cluster-kv called '{secretName}' with the value '{secretValue}' ...")

client.set_secret(secretName, secretValue)

print(" done.")

# print(f"Retrieving your secret from cluster-kv.")
#
# retrieved_secret = client.get_secret(secretName)
#
# print(f"Your secret is '{retrieved_secret.value}'.")
# print(f"Deleting your secret from cluster-kv ...")
#
# poller = client.begin_delete_secret(secretName)
# deleted_secret = poller.result()
#
# print(" done.")

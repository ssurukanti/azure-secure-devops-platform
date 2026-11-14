# Rotate a service principal secret (generalized example).
# Replace the placeholder values. Never commit a real secret.
# Requires: Az PowerShell module, az login, and Application Administrator rights.

param(
  [Parameter(Mandatory = $true)][string]$AppId,
  [Parameter(Mandatory = $true)][string]$DisplayName = "rotated-secret"
)

$secret = New-AzADAppCredential -ApplicationId $AppId -DisplayName $DisplayName
# Store $secret.SecretText in Key Vault / Vault immediately, then remove it
# from this session. Do NOT print it, log it, or commit it.
Write-Host "New secret created for $AppId. Store it in Key Vault now."
# TODO: Add-AzKeyVaultSecret -VaultName "<your-vault>" -Name "<secret-name>" -SecretValue $secret.SecretText

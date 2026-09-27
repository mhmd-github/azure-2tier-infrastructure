// Parameters configure dynamic values during deployment
param location string = resourceGroup().location
param storagePrefix string = 'stbicep'

// Generates a unique 24-character globally unique storage account name
var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

// Resource declaration
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Output returns the created resource name to the terminal
output createdStorageName string = storageAccount.name

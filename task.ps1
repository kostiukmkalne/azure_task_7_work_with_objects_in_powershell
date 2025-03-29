# Define the folder containing JSON files
$dataFolder = "data"
$outputFile = "result.json"

# Initialize an array to store regions where the VM size is found
$matchingRegions = @()

# Get a list of all JSON files in the data folder
$files = Get-ChildItem -Path $dataFolder -Filter "*.json"

# Loop through each file
foreach ($file in $files) {
    # Get the full file path
    $filePath = $file.FullName

    # Extract the region name by removing the ".json" extension
    $regionName = $file.Name.Replace(".json", "")

    # Read and convert JSON content into a PowerShell object
    $vmSizes = Get-Content -Raw -Path $filePath | ConvertFrom-Json

    # Loop through each VM size and check if the target VM size exists
    foreach ($vm in $vmSizes) {
        if ($vm.Name -eq "Standard_B2pts_v2") {
            $matchingRegions += $regionName
            break  # Exit the loop once the VM size is found
        }
    }
}

# Convert the list of matching regions to JSON format and save to the output file
$matchingRegions | ConvertTo-Json | Set-Content -Path $outputFile

Write-Host "Regions with the VM size 'Standard_B2pts_v2':"
Write-Host $matchingRegions

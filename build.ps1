param (
    [string]$Port = ""
)

$ErrorActionPreference = "Stop"

$CoreVersion = "2.1.4"
# FQBN for M5Stack Core in v2.1.4 seems to be m5stack:esp32:m5stack_core
$FQBN = "m5stack:esp32:m5stack_core" 
$SketchName = "M5Stack-SwitchControlerMonitor.ino"

Write-Output "--- M5Stack Build Script (Core v$CoreVersion) ---"

# 1. Install Core
Write-Output "Checking Core m5stack:esp32@$CoreVersion..."
# Check if core is installed to avoid slow update-index
$CoreList = arduino-cli core list | Out-String
if ($CoreList -match "m5stack:esp32\s+$CoreVersion") {
    Write-Output "Core $CoreVersion already installed."
}
else {
    Write-Output "Installing Core..."
    arduino-cli core update-index
    arduino-cli core install m5stack:esp32@$CoreVersion
}

# 2. Install Libraries
Write-Output "Checking Libraries..."
$LibList = arduino-cli lib list | Out-String

if ($LibList -match "M5Stack") {
    Write-Output "Library M5Stack found (skipping install check)."
}
else {
    arduino-cli lib install "M5Stack"
}

if ($LibList -match "USB Host Shield Library 2.0") {
    Write-Output "Library USB Host Shield Library 2.0 found (skipping install check)."
}
else {
    arduino-cli lib install "USB Host Shield Library 2.0"
}

# 3. Compile
Write-Output "Compiling $SketchName..."
Write-Output "FQBN: $FQBN"
arduino-cli compile --fqbn $FQBN .

if ($LASTEXITCODE -eq 0) {
    Write-Output "Build successful!"
}
else {
    Write-Output "Build failed!"
    exit 1
}

# 4. Upload
if ($Port -eq "") {
    Write-Output "Detecting COM port..."
    $BoardListOutput = arduino-cli board list | Out-String
    Write-Output $BoardListOutput

    # Simple parsing to find a likely port (first COM port found)
    $Lines = $BoardListOutput -split "`r`n"
    foreach ($Line in $Lines) {
        if ($Line -match "(COM\d+)") {
            $Port = $matches[1]
            break
        }
    }
}
else {
    Write-Output "Using specified port: $Port"
}

if ($Port) {
    Write-Output "Found port: $Port"
    Write-Output "Uploading to $Port..."
    arduino-cli upload -p $Port --fqbn $FQBN .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Upload successful!"
    }
    else {
        Write-Output "Upload failed!"
        exit 1
    }
}
else {
    Write-Output "No COM port found. Connect M5Stack and retry."
    exit 1
}

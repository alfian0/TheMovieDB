#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -key <debug_api_key> -base <debug_api_base_url> -img <debug_api_image_placeholder>"
    exit 1
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -key) API_KEY="$2"; shift ;;
        -base) API_BASE_URL="$2"; shift ;;
        -img) API_IMAGE_PLACEHOLDER="$2"; shift ;;
        *) usage ;;
    esac
    shift
done

# Check if all parameters are provided
if [[ -z "$API_KEY" || -z "$API_BASE_URL" || -z "$API_IMAGE_PLACEHOLDER" ]]; then
    usage
fi

# Create and write to Debug.xcconfig
echo "Creating Debug.xcconfig..."
cat <<EOL > TheMovieDB/Config/Debug.xcconfig
API_KEY = $API_KEY
API_BASE_URL = $API_BASE_URL
API_IMAGE_PLACEHOLDER = $API_IMAGE_PLACEHOLDER
EOL

# Create and write to Release.xcconfig
echo "Creating Release.xcconfig..."
cat <<EOL > TheMovieDB/Config/Release.xcconfig
API_KEY = $API_KEY
API_BASE_URL = $API_BASE_URL
API_IMAGE_PLACEHOLDER = $API_IMAGE_PLACEHOLDER
EOL

echo "xcconfig files created successfully."

#!/bin/bash

# Path to the forecast fragment and index.html
FORECAST_FRAGMENT="forecast_fragment.html"
INDEX_HTML="index.html"

# Marker or placeholder in index.html to indicate where to insert the forecast
PLACEHOLDER="<!-- forecast_placeholder -->"

# Use sed to replace the placeholder with the forecast content
sed -i "/${PLACEHOLDER}/{
    s/${PLACEHOLDER}//g
    r ${FORECAST_FRAGMENT}
}" ${INDEX_HTML}

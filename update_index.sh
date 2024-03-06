#!/bin/bash

# Path to the forecast fragment and index.html
FORECAST_FRAGMENT="forecast_fragment.html"
INDEX_HTML="index.html"

# Use sed to replace the placeholder with the forecast content
sed -i "/<!-- forecast_placeholder -->/r ${FORECAST_FRAGMENT}" ${INDEX_HTML}
sed -i "/<!-- forecast_placeholder -->/d" ${INDEX_HTML}

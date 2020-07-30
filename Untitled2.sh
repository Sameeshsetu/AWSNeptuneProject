echo "Removing REST API"
REST_API_ID=$(aws apigateway get-rest-apis \
  --query 'items[?name==`Recommendations API`].id' \
  --output text)

API=$(aws apigateway delete-rest-api \
  --rest-api-id ${REST_API_ID})



# SwaggerClient::CardTokenisationsApi

All URIs are relative to *https://gateway.cashflows.com/payment-gateway-api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_gateway_card_tokenisation_post**](CardTokenisationsApi.md#api_gateway_card_tokenisation_post) | **POST** /api/gateway/card-tokenisation | 

# **api_gateway_card_tokenisation_post**
> CardTokenisationResponse api_gateway_card_tokenisation_post(opts)



### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::CardTokenisationsApi.new
opts = { 
  body: SwaggerClient::CardTokenisationRequest.new # CardTokenisationRequest | 
  configuration_id: 'configuration_id_example' # String | 
  hash: 'hash_example' # String | 
  locale: SwaggerClient::Locale.new # Locale | 
}

begin
  result = api_instance.api_gateway_card_tokenisation_post(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling CardTokenisationsApi->api_gateway_card_tokenisation_post: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CardTokenisationRequest**](CardTokenisationRequest.md)|  | [optional] 
 **configuration_id** | **String**|  | [optional] 
 **hash** | **String**|  | [optional] 
 **locale** | [**Locale**](.md)|  | [optional] 

### Return type

[**CardTokenisationResponse**](CardTokenisationResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json




# SwaggerClient::SupportedPaymentMethodsApi

All URIs are relative to *https://gateway.cashflows.com/payment-gateway-api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_gateway_supported_payment_methods_get**](SupportedPaymentMethodsApi.md#api_gateway_supported_payment_methods_get) | **GET** /api/gateway/supported-payment-methods | Retrieve supported payment methods

# **api_gateway_supported_payment_methods_get**
> SupportedPaymentMethodsResponse api_gateway_supported_payment_methods_get(opts)

Retrieve supported payment methods

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::SupportedPaymentMethodsApi.new
opts = { 
  configuration_id: 'configuration_id_example', # String | 
  hash: 'hash_example', # String | 
  collect_amount: 1.2, # Float | 
  currency: SwaggerClient::Currency.new, # Currency | 
  all: true, # BOOLEAN | 
  customer_reference: 789, # Integer | 
  locale: SwaggerClient::Locale.new # Locale | 
}

begin
  #Retrieve supported payment methods
  result = api_instance.api_gateway_supported_payment_methods_get(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling SupportedPaymentMethodsApi->api_gateway_supported_payment_methods_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **configuration_id** | **String**|  | [optional] 
 **hash** | **String**|  | [optional] 
 **collect_amount** | **Float**|  | [optional] 
 **currency** | [**Currency**](.md)|  | [optional] 
 **all** | **BOOLEAN**|  | [optional] 
 **customer_reference** | **Integer**|  | [optional] 
 **locale** | [**Locale**](.md)|  | [optional] 

### Return type

[**SupportedPaymentMethodsResponse**](SupportedPaymentMethodsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json




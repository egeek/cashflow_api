# SwaggerClient::OrdersApi

All URIs are relative to *https://gateway.cashflows.com/payment-gateway-api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_gateway_orders_order_number_head**](OrdersApi.md#api_gateway_orders_order_number_head) | **HEAD** /api/gateway/orders/{orderNumber} | Checks if the order exists, but does not return it.

# **api_gateway_orders_order_number_head**
> api_gateway_orders_order_number_head(order_number, configuration_id, hash)

Checks if the order exists, but does not return it.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::OrdersApi.new
order_number = 'order_number_example' # String | The number of the order to check.
configuration_id = 'configuration_id_example' # String | Your configuration ID.
hash = 'hash_example' # String | A hexadecimal sha512 hash of your password + the body.


begin
  #Checks if the order exists, but does not return it.
  api_instance.api_gateway_orders_order_number_head(order_number, configuration_id, hash)
rescue SwaggerClient::ApiError => e
  puts "Exception when calling OrdersApi->api_gateway_orders_order_number_head: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **order_number** | **String**| The number of the order to check. | 
 **configuration_id** | **String**| Your configuration ID. | 
 **hash** | **String**| A hexadecimal sha512 hash of your password + the body. | 

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json




# SwaggerClient::PaymentJobsApi

All URIs are relative to *https://gateway.cashflows.com/payment-gateway-api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**api_gateway_payment_jobs_payment_job_reference_cancel_patch**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_cancel_patch) | **PATCH** /api/gateway/payment-jobs/{paymentJobReference}/cancel | Cancels a payment job.
[**api_gateway_payment_jobs_payment_job_reference_get**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_get) | **GET** /api/gateway/payment-jobs/{paymentJobReference} | Retrieves a payment job.
[**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch) | **PATCH** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/cancel | Cancels a payment.
[**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post) | **POST** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/captures | Creates a capture for a payment.
[**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get) | **GET** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference} | Retrieves a payment.
[**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post**](PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post) | **POST** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/refunds | Creates a refund for a payment.
[**api_gateway_payment_jobs_post**](PaymentJobsApi.md#api_gateway_payment_jobs_post) | **POST** /api/gateway/payment-jobs | Creates a new payment job.

# **api_gateway_payment_jobs_payment_job_reference_cancel_patch**
> PaymentJobResponse api_gateway_payment_jobs_payment_job_reference_cancel_patch(payment_job_reference, opts)

Cancels a payment job.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job to cancel.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Cancels a payment job.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_cancel_patch(payment_job_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_cancel_patch: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job to cancel. | 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**PaymentJobResponse**](PaymentJobResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_payment_job_reference_get**
> PaymentJobResponse api_gateway_payment_jobs_payment_job_reference_get(payment_job_reference, opts)

Retrieves a payment job.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job to retrieve.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Retrieves a payment job.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_get(payment_job_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job to retrieve. | 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**PaymentJobResponse**](PaymentJobResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch**
> PaymentResponse api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch(payment_job_reference, payment_reference, opts)

Cancels a payment.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to cancel.
payment_reference = 789 # Integer | The reference of the payment to cancel.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Cancels a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch(payment_job_reference, payment_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job which payment to cancel. | 
 **payment_reference** | **Integer**| The reference of the payment to cancel. | 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**PaymentResponse**](PaymentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post**
> CapturePaymentResponse api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post(payment_job_referencepayment_reference, opts)

Creates a capture for a payment.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to capture.
payment_reference = 789 # Integer | The reference of the payment to create a capture for.
opts = { 
  body: SwaggerClient::CapturePaymentRequest.new # CapturePaymentRequest | 
  configuration_id: 'configuration_id_example' # String | Your configuration ID.
  hash: 'hash_example' # String | A hexadecimal sha512 hash of your password + the body.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a capture for a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post(payment_job_referencepayment_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job which payment to capture. | 
 **payment_reference** | **Integer**| The reference of the payment to create a capture for. | 
 **body** | [**CapturePaymentRequest**](CapturePaymentRequest.md)|  | [optional] 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password + the body. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**CapturePaymentResponse**](CapturePaymentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get**
> PaymentResponse api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get(payment_job_reference, payment_reference, opts)

Retrieves a payment.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to retrieve.
payment_reference = 789 # Integer | The reference of the payment to retrieve.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Retrieves a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get(payment_job_reference, payment_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job which payment to retrieve. | 
 **payment_reference** | **Integer**| The reference of the payment to retrieve. | 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**PaymentResponse**](PaymentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post**
> RefundPaymentResponse api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post(payment_job_referencepayment_reference, opts)

Creates a refund for a payment.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to refund.
payment_reference = 789 # Integer | The reference of the payment to create a refund for.
opts = { 
  body: SwaggerClient::RefundPaymentRequest.new # RefundPaymentRequest | 
  configuration_id: 'configuration_id_example' # String | Your configuration ID.
  hash: 'hash_example' # String | A hexadecimal sha512 hash of your password + the body.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a refund for a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post(payment_job_referencepayment_reference, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payment_job_reference** | **Integer**| The reference of the payment job which payment to refund. | 
 **payment_reference** | **Integer**| The reference of the payment to create a refund for. | 
 **body** | [**RefundPaymentRequest**](RefundPaymentRequest.md)|  | [optional] 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password + the body. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**RefundPaymentResponse**](RefundPaymentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json



# **api_gateway_payment_jobs_post**
> PaymentJobResponse api_gateway_payment_jobs_post(opts)

Creates a new payment job.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::PaymentJobsApi.new
opts = { 
  body: SwaggerClient::CreatePaymentJobRequest.new # CreatePaymentJobRequest | 
  configuration_id: 'configuration_id_example' # String | Your configuration ID.
  hash: 'hash_example' # String | A hexadecimal sha512 hash of your password + the body.
  locale: SwaggerClient::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a new payment job.
  result = api_instance.api_gateway_payment_jobs_post(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_post: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreatePaymentJobRequest**](CreatePaymentJobRequest.md)|  | [optional] 
 **configuration_id** | **String**| Your configuration ID. | [optional] 
 **hash** | **String**| A hexadecimal sha512 hash of your password + the body. | [optional] 
 **locale** | [**Locale**](.md)| The locale to translate errors and warnings to. | [optional] 

### Return type

[**PaymentJobResponse**](PaymentJobResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json




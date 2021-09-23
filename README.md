# CashFlowsApi

CashFlowsApi - the Ruby gem for the Payment Gateway API

# API Reference Documentation The Payment Gateway API provides an API for creating new payment jobs, refunds and other payment related operations. This service handles extensive validation and conversion for each request, as well as providing a security layer by doing authentication and authorisation checks. ## Signing API calls To assure message consistency and making it hard to execute a man in the middle attack, all messages are signed with a SHA512 hash. This hash is calculated by appending the body data to the API password (password comes first). The calculated hash is converted to a hex-string and send in the header with `Hash: xxxxxx`. If the message body is empty just hash the password.  The gateway has the ability to have 2 passwords available at one time. When altering a password you first create a new second password. If all the systems have migrated to the new password than you can remove the first password. This way you can alter a password without having migration downtime. ## ConfigurationId header If you have been setup to use the gateway you will receive a configuration id. The configuration id identifies your application to the gateway with it's defined setup properies. Beside the hash you will have to supply the configuration id in the html header of each call to the gateway. The header format should look like: `ConfigurationId: xxxxx`. ## Webhooks It is important for a smooth and safe operation of a payment application to implement web hooks. A web hook is an api endpoint you create on your server implementation. This endpoint will be called from the gateway software on status changes of your payment job. This way you avoid having to poll for payment status changes, instead you will be notified of payment jobs for which the status has changed.  The gateway will perform a POST operation at the specified webhook url when the status of a paymentjob changes. For example from `Pending` to `Paid`. The body consist of notifyType, PaymentjobReference and PaymentReference.  The payment application can use the paymentjobReference and check it's status. Typically an internal delivery process is started for the order involved if the status is `Paid` or `Reserved`. The gateway expects a json response with httpstatus 200 OK, confirming the paymentjobreference and paymentreference.  ````json {  paymentJobReference: \"200421017498767380\",  paymentReference: \"200421100461508616\" } ````  When the gateway receives the confirmed paymentjobReference and paymentReference the webhook procedure will end until another status change occurs. If the response does not contain the expected json with a httpstatus 200 OK, or there is no response at all, the webhook call will get repeated at different intervals. ## Populating payment methods in the checkoutpage When you are performing a shop integration there will be a section in the checkout page where the paymentmethods should be presented to the buyer. We provide an api call _SupportedPaymentMethods_ to populate this section.  This call will provide all the available paymentmethods for this checkout, including payment logo's, surcharges etc. By implementing the result data of this call correctly will make the checkout page ready for all future paymentmethods, avoiding having to do development eachtime a new paymentmethod becomes available. ## Creating a basic paymentjob In order to collect money a paymentjob should be created. We assume you have setup paymentmethods in the configuration and a set of redirect urls for a paid, failed or cancelled payment. As a minimum you specify the amount to collect, currency and localisation for the paymentjob. As a response you will receive a redirect link (action link) where you should redirect the browser of the buyer too in order to complete the payment. This minimum requirement to start a paymentjob is in many cases not sufficient. We advise to at least supply the ordernumber and the billingidentity email when creating a paymentjob. Generally speaking, supply all that you know. Without this information, payment lookup and reconciliation of payments will become a hard job if at all possible. ## Direct acquiring f you are PCI-DSS compliant you can use the gateway to perform card acquiring. By direct acquiring we mean that you gather the card information on your servers and create a paymentjob whilst supplying the card information at the start of a payment. If a 3dSecure call is needed the redirectlink will point you to the 3d secure supplier. If the payment is directly approved you can still use the redirectlink but in that case it will point to the defined success url if the card is authorized. ## Reservations and captures If your business requires you to perform (card) reservations (also called authorisations) first and capture the reservations later, the gateway can support this scenario. The ability to first reserve an amount and later capture this amount, can be set in the configuration and corresponding payment method. The default for autoCapture is true. So if you do not set autoCapture to false authorised amounts are always immediatly captured.  Scenario's where you would want to set autoCapture to false are in cases where you can not deliver the goods immediatly. In this scenario you just want to capture the amount at the time you are ready to deliver the goods and in the meantime want to be sure that when the goods arrive you will receive the reserved funds.  So if you have set autoCapture to false you must manually capture the amount via a seperate api call if the paymentjob status has reached the Reserved status. As soon as the paymentjob reaches the status Reserved you can capture the reserved amount. If you do not specify `AmountToCapture` the full reserved amount will be captured. In case of card capturing the full amount is the only option now.  The cookbook to create a reservation/capture scenario is to start paymentjobs as normal, having the configuration setting for the paymentmethod set to autoCapture false value. And then call Capture as soon as the paymentjob status turns into Reserved and you are ready to deliver. ## Refunds  When you want to refund an amount because for example goods are returned you can call the Refunds method to refund an amount. In order to do so you need the paymentjobreference and paymentreference of the payment within the paymentjob that was used to pay an amount. You can not refund more in one call than the amount that was paid using the paymentmethod referenced by the paymentreference. Technically there can be multiple payments in a paymentjob that have brought together the amount paid in total.

This SDK is automatically generated by the [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) project:

- API version: v1
- Package version: 1.0.0
- Build package: io.swagger.codegen.v3.generators.ruby.RubyClientCodegen
For more information, please visit [https://www.cashflows.com](https://www.cashflows.com)

## Installation

### Build a gem

To build the Ruby code into a gem:

```shell
gem build CashFlowsApi.gemspec
```

Then either install the gem locally:

```shell
gem install ./CashFlowsApi-1.0.0.gem
```
(for development, run `gem install --dev ./CashFlowsApi-1.0.0.gem` to install the development dependencies)

or publish the gem to a gem hosting service, e.g. [RubyGems](https://rubygems.org/).

Finally add this to the Gemfile:

    gem 'CashFlowsApi', '~> 1.0.0'

### Install from Git

If the Ruby gem is hosted at a git repository: https://github.com/GIT_USER_ID/GIT_REPO_ID, then add the following in the Gemfile:

    gem 'CashFlowsApi', :git => 'https://github.com/GIT_USER_ID/GIT_REPO_ID.git'

### Include the Ruby code directly

Include the Ruby code directly using `-I` as follows:

```shell
ruby -Ilib script.rb
```

## Getting Started

Please follow the [installation](#installation) procedure and then run the following code:
```ruby
# Load the gem
require 'CashFlowsApi'

api_instance = CashFlowsApi::CardTokenisationsApi.new
opts = { 
  body: CashFlowsApi::CardTokenisationRequest.new, # CardTokenisationRequest | 
  configuration_id: 'configuration_id_example', # String | 
  hash: 'hash_example', # String | 
  locale: CashFlowsApi::Locale.new # Locale | 
}

begin
  result = api_instance.api_gateway_card_tokenisation_post(opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling CardTokenisationsApi->api_gateway_card_tokenisation_post: #{e}"
end

api_instance = CashFlowsApi::OrdersApi.new
order_number = 'order_number_example' # String | The number of the order to check.
configuration_id = 'configuration_id_example' # String | Your configuration ID.
hash = 'hash_example' # String | A hexadecimal sha512 hash of your password + the body.


begin
  #Checks if the order exists, but does not return it.
  api_instance.api_gateway_orders_order_number_head(order_number, configuration_id, hash)
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling OrdersApi->api_gateway_orders_order_number_head: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job to cancel.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Cancels a payment job.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_cancel_patch(payment_job_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_cancel_patch: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job to retrieve.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Retrieves a payment job.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_get(payment_job_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_get: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to cancel.
payment_reference = 789 # Integer | The reference of the payment to cancel.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Cancels a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch(payment_job_reference, payment_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to capture.
payment_reference = 789 # Integer | The reference of the payment to create a capture for.
opts = { 
  body: CashFlowsApi::CapturePaymentRequest.new, # CapturePaymentRequest | 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password + the body.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a capture for a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post(payment_job_reference, payment_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to retrieve.
payment_reference = 789 # Integer | The reference of the payment to retrieve.
opts = { 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Retrieves a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get(payment_job_reference, payment_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
payment_job_reference = 789 # Integer | The reference of the payment job which payment to refund.
payment_reference = 789 # Integer | The reference of the payment to create a refund for.
opts = { 
  body: CashFlowsApi::RefundPaymentRequest.new, # RefundPaymentRequest | 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password + the body.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a refund for a payment.
  result = api_instance.api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post(payment_job_reference, payment_reference, opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post: #{e}"
end

api_instance = CashFlowsApi::PaymentJobsApi.new
opts = { 
  body: CashFlowsApi::CreatePaymentJobRequest.new, # CreatePaymentJobRequest | 
  configuration_id: 'configuration_id_example', # String | Your configuration ID.
  hash: 'hash_example', # String | A hexadecimal sha512 hash of your password + the body.
  locale: CashFlowsApi::Locale.new # Locale | The locale to translate errors and warnings to.
}

begin
  #Creates a new payment job.
  result = api_instance.api_gateway_payment_jobs_post(opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling PaymentJobsApi->api_gateway_payment_jobs_post: #{e}"
end

api_instance = CashFlowsApi::SupportedPaymentMethodsApi.new
opts = { 
  configuration_id: 'configuration_id_example', # String | 
  hash: 'hash_example', # String | 
  collect_amount: 1.2, # Float | 
  currency: CashFlowsApi::Currency.new, # Currency | 
  all: true, # BOOLEAN | 
  customer_reference: 789, # Integer | 
  locale: CashFlowsApi::Locale.new # Locale | 
}

begin
  #Retrieve supported payment methods
  result = api_instance.api_gateway_supported_payment_methods_get(opts)
  p result
rescue CashFlowsApi::ApiError => e
  puts "Exception when calling SupportedPaymentMethodsApi->api_gateway_supported_payment_methods_get: #{e}"
end
```

## Documentation for API Endpoints

All URIs are relative to *https://gateway.cashflows.com/payment-gateway-api*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*CashFlowsApi::CardTokenisationsApi* | [**api_gateway_card_tokenisation_post**](docs/CardTokenisationsApi.md#api_gateway_card_tokenisation_post) | **POST** /api/gateway/card-tokenisation | 
*CashFlowsApi::OrdersApi* | [**api_gateway_orders_order_number_head**](docs/OrdersApi.md#api_gateway_orders_order_number_head) | **HEAD** /api/gateway/orders/{orderNumber} | Checks if the order exists, but does not return it.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_cancel_patch**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_cancel_patch) | **PATCH** /api/gateway/payment-jobs/{paymentJobReference}/cancel | Cancels a payment job.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_get**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_get) | **GET** /api/gateway/payment-jobs/{paymentJobReference} | Retrieves a payment job.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_cancel_patch) | **PATCH** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/cancel | Cancels a payment.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_captures_post) | **POST** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/captures | Creates a capture for a payment.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_get) | **GET** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference} | Retrieves a payment.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_payment_job_reference_payments_payment_reference_refunds_post) | **POST** /api/gateway/payment-jobs/{paymentJobReference}/payments/{paymentReference}/refunds | Creates a refund for a payment.
*CashFlowsApi::PaymentJobsApi* | [**api_gateway_payment_jobs_post**](docs/PaymentJobsApi.md#api_gateway_payment_jobs_post) | **POST** /api/gateway/payment-jobs | Creates a new payment job.
*CashFlowsApi::SupportedPaymentMethodsApi* | [**api_gateway_supported_payment_methods_get**](docs/SupportedPaymentMethodsApi.md#api_gateway_supported_payment_methods_get) | **GET** /api/gateway/supported-payment-methods | Retrieve supported payment methods

## Documentation for Models

 - [CashFlowsApi::AbuseReport](docs/AbuseReport.md)
 - [CashFlowsApi::AbuseTrigger](docs/AbuseTrigger.md)
 - [CashFlowsApi::Address](docs/Address.md)
 - [CashFlowsApi::Capture](docs/Capture.md)
 - [CashFlowsApi::CaptureAttributes](docs/CaptureAttributes.md)
 - [CashFlowsApi::CapturePaymentRequest](docs/CapturePaymentRequest.md)
 - [CashFlowsApi::CapturePaymentResponse](docs/CapturePaymentResponse.md)
 - [CashFlowsApi::CaptureStatus](docs/CaptureStatus.md)
 - [CashFlowsApi::CardTokenData](docs/CardTokenData.md)
 - [CashFlowsApi::CardTokenisationRequest](docs/CardTokenisationRequest.md)
 - [CashFlowsApi::CardTokenisationResponse](docs/CardTokenisationResponse.md)
 - [CashFlowsApi::Country](docs/Country.md)
 - [CashFlowsApi::CreatePaymentJobRequest](docs/CreatePaymentJobRequest.md)
 - [CashFlowsApi::CreatePaymentJobRequestParameters](docs/CreatePaymentJobRequestParameters.md)
 - [CashFlowsApi::Currency](docs/Currency.md)
 - [CashFlowsApi::Entry](docs/Entry.md)
 - [CashFlowsApi::ErrorReport](docs/ErrorReport.md)
 - [CashFlowsApi::ErrorResponse](docs/ErrorResponse.md)
 - [CashFlowsApi::GatewayPaymentMethod](docs/GatewayPaymentMethod.md)
 - [CashFlowsApi::Gender](docs/Gender.md)
 - [CashFlowsApi::Identity](docs/Identity.md)
 - [CashFlowsApi::Issuer](docs/Issuer.md)
 - [CashFlowsApi::Link](docs/Link.md)
 - [CashFlowsApi::Links](docs/Links.md)
 - [CashFlowsApi::Locale](docs/Locale.md)
 - [CashFlowsApi::Order](docs/Order.md)
 - [CashFlowsApi::OrderLine](docs/OrderLine.md)
 - [CashFlowsApi::OrderLineType](docs/OrderLineType.md)
 - [CashFlowsApi::Payment](docs/Payment.md)
 - [CashFlowsApi::PaymentAttributes](docs/PaymentAttributes.md)
 - [CashFlowsApi::PaymentJob](docs/PaymentJob.md)
 - [CashFlowsApi::PaymentJobAttributes](docs/PaymentJobAttributes.md)
 - [CashFlowsApi::PaymentJobFlags](docs/PaymentJobFlags.md)
 - [CashFlowsApi::PaymentJobOption](docs/PaymentJobOption.md)
 - [CashFlowsApi::PaymentJobResponse](docs/PaymentJobResponse.md)
 - [CashFlowsApi::PaymentJobType](docs/PaymentJobType.md)
 - [CashFlowsApi::PaymentMethod](docs/PaymentMethod.md)
 - [CashFlowsApi::PaymentMethodInfo](docs/PaymentMethodInfo.md)
 - [CashFlowsApi::PaymentResponse](docs/PaymentResponse.md)
 - [CashFlowsApi::PaymentStatus](docs/PaymentStatus.md)
 - [CashFlowsApi::PaymentStep](docs/PaymentStep.md)
 - [CashFlowsApi::PaymentStepAction](docs/PaymentStepAction.md)
 - [CashFlowsApi::PhoneNumberType](docs/PhoneNumberType.md)
 - [CashFlowsApi::RecurrenceCriteria](docs/RecurrenceCriteria.md)
 - [CashFlowsApi::RecurrenceType](docs/RecurrenceType.md)
 - [CashFlowsApi::Refund](docs/Refund.md)
 - [CashFlowsApi::RefundAttributes](docs/RefundAttributes.md)
 - [CashFlowsApi::RefundPaymentRequest](docs/RefundPaymentRequest.md)
 - [CashFlowsApi::RefundPaymentResponse](docs/RefundPaymentResponse.md)
 - [CashFlowsApi::RefundStatus](docs/RefundStatus.md)
 - [CashFlowsApi::RefundStep](docs/RefundStep.md)
 - [CashFlowsApi::RefundStepAction](docs/RefundStepAction.md)
 - [CashFlowsApi::SupportedPaymentMethodsResponse](docs/SupportedPaymentMethodsResponse.md)
 - [CashFlowsApi::TokenisedCard](docs/TokenisedCard.md)
 - [CashFlowsApi::UpdateOrderRequest](docs/UpdateOrderRequest.md)

## Documentation for Authorization

 All endpoints do not require authorization.


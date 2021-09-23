=begin
#Payment Gateway API

## API Reference Documentation The Payment Gateway API provides an API for creating new payment jobs, refunds and other payment related operations. This service handles extensive validation and conversion for each request, as well as providing a security layer by doing authentication and authorisation checks. ## Signing API calls To assure message consistency and making it hard to execute a man in the middle attack, all messages are signed with a SHA512 hash. This hash is calculated by appending the body data to the API password (password comes first). The calculated hash is converted to a hex-string and send in the header with `Hash: xxxxxx`. If the message body is empty just hash the password.  The gateway has the ability to have 2 passwords available at one time. When altering a password you first create a new second password. If all the systems have migrated to the new password than you can remove the first password. This way you can alter a password without having migration downtime. ## ConfigurationId header If you have been setup to use the gateway you will receive a configuration id. The configuration id identifies your application to the gateway with it's defined setup properies. Beside the hash you will have to supply the configuration id in the html header of each call to the gateway. The header format should look like: `ConfigurationId: xxxxx`. ## Webhooks It is important for a smooth and safe operation of a payment application to implement web hooks. A web hook is an api endpoint you create on your server implementation. This endpoint will be called from the gateway software on status changes of your payment job. This way you avoid having to poll for payment status changes, instead you will be notified of payment jobs for which the status has changed.  The gateway will perform a POST operation at the specified webhook url when the status of a paymentjob changes. For example from `Pending` to `Paid`. The body consist of notifyType, PaymentjobReference and PaymentReference.  The payment application can use the paymentjobReference and check it's status. Typically an internal delivery process is started for the order involved if the status is `Paid` or `Reserved`. The gateway expects a json response with httpstatus 200 OK, confirming the paymentjobreference and paymentreference.  ````json {  paymentJobReference: \"200421017498767380\",  paymentReference: \"200421100461508616\" } ````  When the gateway receives the confirmed paymentjobReference and paymentReference the webhook procedure will end until another status change occurs. If the response does not contain the expected json with a httpstatus 200 OK, or there is no response at all, the webhook call will get repeated at different intervals. ## Populating payment methods in the checkoutpage When you are performing a shop integration there will be a section in the checkout page where the paymentmethods should be presented to the buyer. We provide an api call _SupportedPaymentMethods_ to populate this section.  This call will provide all the available paymentmethods for this checkout, including payment logo's, surcharges etc. By implementing the result data of this call correctly will make the checkout page ready for all future paymentmethods, avoiding having to do development eachtime a new paymentmethod becomes available. ## Creating a basic paymentjob In order to collect money a paymentjob should be created. We assume you have setup paymentmethods in the configuration and a set of redirect urls for a paid, failed or cancelled payment. As a minimum you specify the amount to collect, currency and localisation for the paymentjob. As a response you will receive a redirect link (action link) where you should redirect the browser of the buyer too in order to complete the payment. This minimum requirement to start a paymentjob is in many cases not sufficient. We advise to at least supply the ordernumber and the billingidentity email when creating a paymentjob. Generally speaking, supply all that you know. Without this information, payment lookup and reconciliation of payments will become a hard job if at all possible. ## Direct acquiring f you are PCI-DSS compliant you can use the gateway to perform card acquiring. By direct acquiring we mean that you gather the card information on your servers and create a paymentjob whilst supplying the card information at the start of a payment. If a 3dSecure call is needed the redirectlink will point you to the 3d secure supplier. If the payment is directly approved you can still use the redirectlink but in that case it will point to the defined success url if the card is authorized. ## Reservations and captures If your business requires you to perform (card) reservations (also called authorisations) first and capture the reservations later, the gateway can support this scenario. The ability to first reserve an amount and later capture this amount, can be set in the configuration and corresponding payment method. The default for autoCapture is true. So if you do not set autoCapture to false authorised amounts are always immediatly captured.  Scenario's where you would want to set autoCapture to false are in cases where you can not deliver the goods immediatly. In this scenario you just want to capture the amount at the time you are ready to deliver the goods and in the meantime want to be sure that when the goods arrive you will receive the reserved funds.  So if you have set autoCapture to false you must manually capture the amount via a seperate api call if the paymentjob status has reached the Reserved status. As soon as the paymentjob reaches the status Reserved you can capture the reserved amount. If you do not specify `AmountToCapture` the full reserved amount will be captured. In case of card capturing the full amount is the only option now.  The cookbook to create a reservation/capture scenario is to start paymentjobs as normal, having the configuration setting for the paymentmethod set to autoCapture false value. And then call Capture as soon as the paymentjob status turns into Reserved and you are ready to deliver. ## Refunds  When you want to refund an amount because for example goods are returned you can call the Refunds method to refund an amount. In order to do so you need the paymentjobreference and paymentreference of the payment within the paymentjob that was used to pay an amount. You can not refund more in one call than the amount that was paid using the paymentmethod referenced by the paymentreference. Technically there can be multiple payments in a paymentjob that have brought together the amount paid in total.

OpenAPI spec version: v1
Contact: tech-support@cashflows.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.28-SNAPSHOT
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for SwaggerClient::RefundPaymentResponse
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'RefundPaymentResponse' do
  before do
    # run before each test
    @instance = SwaggerClient::RefundPaymentResponse.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of RefundPaymentResponse' do
    it 'should create an instance of RefundPaymentResponse' do
      expect(@instance).to be_instance_of(SwaggerClient::RefundPaymentResponse)
    end
  end
  describe 'test attribute "data"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "error_report"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "links"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end

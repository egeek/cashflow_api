=begin
#Payment Gateway API

## API Reference Documentation The Payment Gateway API provides an API for creating new payment jobs, refunds and other payment related operations. This service handles extensive validation and conversion for each request, as well as providing a security layer by doing authentication and authorisation checks. ## Signing API calls To assure message consistency and making it hard to execute a man in the middle attack, all messages are signed with a SHA512 hash. This hash is calculated by appending the body data to the API password (password comes first). The calculated hash is converted to a hex-string and send in the header with `Hash: xxxxxx`. If the message body is empty just hash the password.  The gateway has the ability to have 2 passwords available at one time. When altering a password you first create a new second password. If all the systems have migrated to the new password than you can remove the first password. This way you can alter a password without having migration downtime. ## ConfigurationId header If you have been setup to use the gateway you will receive a configuration id. The configuration id identifies your application to the gateway with it's defined setup properies. Beside the hash you will have to supply the configuration id in the html header of each call to the gateway. The header format should look like: `ConfigurationId: xxxxx`. ## Webhooks It is important for a smooth and safe operation of a payment application to implement web hooks. A web hook is an api endpoint you create on your server implementation. This endpoint will be called from the gateway software on status changes of your payment job. This way you avoid having to poll for payment status changes, instead you will be notified of payment jobs for which the status has changed.  The gateway will perform a POST operation at the specified webhook url when the status of a paymentjob changes. For example from `Pending` to `Paid`. The body consist of notifyType, PaymentjobReference and PaymentReference.  The payment application can use the paymentjobReference and check it's status. Typically an internal delivery process is started for the order involved if the status is `Paid` or `Reserved`. The gateway expects a json response with httpstatus 200 OK, confirming the paymentjobreference and paymentreference.  ````json {  paymentJobReference: \"200421017498767380\",  paymentReference: \"200421100461508616\" } ````  When the gateway receives the confirmed paymentjobReference and paymentReference the webhook procedure will end until another status change occurs. If the response does not contain the expected json with a httpstatus 200 OK, or there is no response at all, the webhook call will get repeated at different intervals. ## Populating payment methods in the checkoutpage When you are performing a shop integration there will be a section in the checkout page where the paymentmethods should be presented to the buyer. We provide an api call _SupportedPaymentMethods_ to populate this section.  This call will provide all the available paymentmethods for this checkout, including payment logo's, surcharges etc. By implementing the result data of this call correctly will make the checkout page ready for all future paymentmethods, avoiding having to do development eachtime a new paymentmethod becomes available. ## Creating a basic paymentjob In order to collect money a paymentjob should be created. We assume you have setup paymentmethods in the configuration and a set of redirect urls for a paid, failed or cancelled payment. As a minimum you specify the amount to collect, currency and localisation for the paymentjob. As a response you will receive a redirect link (action link) where you should redirect the browser of the buyer too in order to complete the payment. This minimum requirement to start a paymentjob is in many cases not sufficient. We advise to at least supply the ordernumber and the billingidentity email when creating a paymentjob. Generally speaking, supply all that you know. Without this information, payment lookup and reconciliation of payments will become a hard job if at all possible. ## Direct acquiring f you are PCI-DSS compliant you can use the gateway to perform card acquiring. By direct acquiring we mean that you gather the card information on your servers and create a paymentjob whilst supplying the card information at the start of a payment. If a 3dSecure call is needed the redirectlink will point you to the 3d secure supplier. If the payment is directly approved you can still use the redirectlink but in that case it will point to the defined success url if the card is authorized. ## Reservations and captures If your business requires you to perform (card) reservations (also called authorisations) first and capture the reservations later, the gateway can support this scenario. The ability to first reserve an amount and later capture this amount, can be set in the configuration and corresponding payment method. The default for autoCapture is true. So if you do not set autoCapture to false authorised amounts are always immediatly captured.  Scenario's where you would want to set autoCapture to false are in cases where you can not deliver the goods immediatly. In this scenario you just want to capture the amount at the time you are ready to deliver the goods and in the meantime want to be sure that when the goods arrive you will receive the reserved funds.  So if you have set autoCapture to false you must manually capture the amount via a seperate api call if the paymentjob status has reached the Reserved status. As soon as the paymentjob reaches the status Reserved you can capture the reserved amount. If you do not specify `AmountToCapture` the full reserved amount will be captured. In case of card capturing the full amount is the only option now.  The cookbook to create a reservation/capture scenario is to start paymentjobs as normal, having the configuration setting for the paymentmethod set to autoCapture false value. And then call Capture as soon as the paymentjob status turns into Reserved and you are ready to deliver. ## Refunds  When you want to refund an amount because for example goods are returned you can call the Refunds method to refund an amount. In order to do so you need the paymentjobreference and paymentreference of the payment within the paymentjob that was used to pay an amount. You can not refund more in one call than the amount that was paid using the paymentmethod referenced by the paymentreference. Technically there can be multiple payments in a paymentjob that have brought together the amount paid in total.

OpenAPI spec version: v1
Contact: tech-support@cashflows.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.28-SNAPSHOT
=end

require 'date'

module CashFlowsApi
  # Additional parameters, like AutoInvoice, and HostedNotCancelable to use when executing the request,  as well as payment method specific parameters, like BIC for iDEAL, for use by one or more payment methods.
  class CreatePaymentJobRequestParameters
    attr_accessor :originating_ip_address

    attr_accessor :origin_header

    attr_accessor :user_agent

    attr_accessor :three_d_secure_challenge_accept_header

    attr_accessor :three_d_secure_v2_challenge_window_size

    attr_accessor :browser_language

    attr_accessor :browser_time_zone_offset

    attr_accessor :browser_java_enabled

    attr_accessor :browser_java_script_enabled

    attr_accessor :browser_screen_height

    attr_accessor :browser_screen_width

    attr_accessor :browser_screen_color_depth

    attr_accessor :return_url_success

    attr_accessor :return_url_failed

    attr_accessor :return_url_cancelled

    attr_accessor :webhook_url

    attr_accessor :payment_page_reference

    attr_accessor :simulated_status

    attr_accessor :ideal_bic

    attr_accessor :selected_payment_method

    attr_accessor :card_number

    attr_accessor :card_cvc

    attr_accessor :card_expiry_month

    attr_accessor :card_expiry_year

    attr_accessor :card_holder_name

    attr_accessor :mcc

    attr_accessor :recipient_details

    attr_accessor :pa_res

    attr_accessor :md

    attr_accessor :r_req

    attr_accessor :c_res

    attr_accessor :three_ds_session_data

    attr_accessor :three_ds_method_data

    attr_accessor :three_d_secure_xid

    attr_accessor :three_d_secure_cavv

    attr_accessor :three_d_secure_eci

    attr_accessor :three_d_secure_version

    attr_accessor :three_d_secure_ds_trans_id

    attr_accessor :token

    attr_accessor :payer_id

    attr_accessor :google_analytics_client_id

    attr_accessor :allowed_parent_frame_domains

    attr_accessor :descriptor

    attr_accessor :e_wallet_type

    attr_accessor :apple_pay_transaction_identifier

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'originating_ip_address' => :'OriginatingIpAddress',
        :'origin_header' => :'OriginHeader',
        :'user_agent' => :'UserAgent',
        :'three_d_secure_challenge_accept_header' => :'ThreeDSecureChallengeAcceptHeader',
        :'three_d_secure_v2_challenge_window_size' => :'ThreeDSecureV2ChallengeWindowSize',
        :'browser_language' => :'BrowserLanguage',
        :'browser_time_zone_offset' => :'BrowserTimeZoneOffset',
        :'browser_java_enabled' => :'BrowserJavaEnabled',
        :'browser_java_script_enabled' => :'BrowserJavaScriptEnabled',
        :'browser_screen_height' => :'BrowserScreenHeight',
        :'browser_screen_width' => :'BrowserScreenWidth',
        :'browser_screen_color_depth' => :'BrowserScreenColorDepth',
        :'return_url_success' => :'ReturnUrlSuccess',
        :'return_url_failed' => :'ReturnUrlFailed',
        :'return_url_cancelled' => :'ReturnUrlCancelled',
        :'webhook_url' => :'WebhookUrl',
        :'payment_page_reference' => :'PaymentPageReference',
        :'simulated_status' => :'SimulatedStatus',
        :'ideal_bic' => :'IdealBic',
        :'selected_payment_method' => :'SelectedPaymentMethod',
        :'card_number' => :'CardNumber',
        :'card_cvc' => :'CardCvc',
        :'card_expiry_month' => :'CardExpiryMonth',
        :'card_expiry_year' => :'CardExpiryYear',
        :'card_holder_name' => :'CardHolderName',
        :'mcc' => :'Mcc',
        :'recipient_details' => :'RecipientDetails',
        :'pa_res' => :'PaRes',
        :'md' => :'Md',
        :'r_req' => :'RReq',
        :'c_res' => :'CRes',
        :'three_ds_session_data' => :'ThreeDSSessionData',
        :'three_ds_method_data' => :'ThreeDSMethodData',
        :'three_d_secure_xid' => :'ThreeDSecureXid',
        :'three_d_secure_cavv' => :'ThreeDSecureCavv',
        :'three_d_secure_eci' => :'ThreeDSecureEci',
        :'three_d_secure_version' => :'ThreeDSecureVersion',
        :'three_d_secure_ds_trans_id' => :'ThreeDSecureDSTransId',
        :'token' => :'Token',
        :'payer_id' => :'PayerId',
        :'google_analytics_client_id' => :'GoogleAnalyticsClientId',
        :'allowed_parent_frame_domains' => :'AllowedParentFrameDomains',
        :'descriptor' => :'Descriptor',
        :'e_wallet_type' => :'EWalletType',
        :'apple_pay_transaction_identifier' => :'ApplePayTransactionIdentifier'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'originating_ip_address' => :'Object',
        :'origin_header' => :'Object',
        :'user_agent' => :'Object',
        :'three_d_secure_challenge_accept_header' => :'Object',
        :'three_d_secure_v2_challenge_window_size' => :'Object',
        :'browser_language' => :'Object',
        :'browser_time_zone_offset' => :'Object',
        :'browser_java_enabled' => :'Object',
        :'browser_java_script_enabled' => :'Object',
        :'browser_screen_height' => :'Object',
        :'browser_screen_width' => :'Object',
        :'browser_screen_color_depth' => :'Object',
        :'return_url_success' => :'Object',
        :'return_url_failed' => :'Object',
        :'return_url_cancelled' => :'Object',
        :'webhook_url' => :'Object',
        :'payment_page_reference' => :'Object',
        :'simulated_status' => :'Object',
        :'ideal_bic' => :'Object',
        :'selected_payment_method' => :'Object',
        :'card_number' => :'Object',
        :'card_cvc' => :'Object',
        :'card_expiry_month' => :'Object',
        :'card_expiry_year' => :'Object',
        :'card_holder_name' => :'Object',
        :'mcc' => :'Object',
        :'recipient_details' => :'Object',
        :'pa_res' => :'Object',
        :'md' => :'Object',
        :'r_req' => :'Object',
        :'c_res' => :'Object',
        :'three_ds_session_data' => :'Object',
        :'three_ds_method_data' => :'Object',
        :'three_d_secure_xid' => :'Object',
        :'three_d_secure_cavv' => :'Object',
        :'three_d_secure_eci' => :'Object',
        :'three_d_secure_version' => :'Object',
        :'three_d_secure_ds_trans_id' => :'Object',
        :'token' => :'Object',
        :'payer_id' => :'Object',
        :'google_analytics_client_id' => :'Object',
        :'allowed_parent_frame_domains' => :'Object',
        :'descriptor' => :'Object',
        :'e_wallet_type' => :'Object',
        :'apple_pay_transaction_identifier' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `CashFlowsApi::CreatePaymentJobRequestParameters` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `CashFlowsApi::CreatePaymentJobRequestParameters`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'originating_ip_address')
        self.originating_ip_address = attributes[:'originating_ip_address']
      end

      if attributes.key?(:'origin_header')
        self.origin_header = attributes[:'origin_header']
      end

      if attributes.key?(:'user_agent')
        self.user_agent = attributes[:'user_agent']
      end

      if attributes.key?(:'three_d_secure_challenge_accept_header')
        self.three_d_secure_challenge_accept_header = attributes[:'three_d_secure_challenge_accept_header']
      end

      if attributes.key?(:'three_d_secure_v2_challenge_window_size')
        self.three_d_secure_v2_challenge_window_size = attributes[:'three_d_secure_v2_challenge_window_size']
      end

      if attributes.key?(:'browser_language')
        self.browser_language = attributes[:'browser_language']
      end

      if attributes.key?(:'browser_time_zone_offset')
        self.browser_time_zone_offset = attributes[:'browser_time_zone_offset']
      end

      if attributes.key?(:'browser_java_enabled')
        self.browser_java_enabled = attributes[:'browser_java_enabled']
      end

      if attributes.key?(:'browser_java_script_enabled')
        self.browser_java_script_enabled = attributes[:'browser_java_script_enabled']
      end

      if attributes.key?(:'browser_screen_height')
        self.browser_screen_height = attributes[:'browser_screen_height']
      end

      if attributes.key?(:'browser_screen_width')
        self.browser_screen_width = attributes[:'browser_screen_width']
      end

      if attributes.key?(:'browser_screen_color_depth')
        self.browser_screen_color_depth = attributes[:'browser_screen_color_depth']
      end

      if attributes.key?(:'return_url_success')
        self.return_url_success = attributes[:'return_url_success']
      end

      if attributes.key?(:'return_url_failed')
        self.return_url_failed = attributes[:'return_url_failed']
      end

      if attributes.key?(:'return_url_cancelled')
        self.return_url_cancelled = attributes[:'return_url_cancelled']
      end

      if attributes.key?(:'webhook_url')
        self.webhook_url = attributes[:'webhook_url']
      end

      if attributes.key?(:'payment_page_reference')
        self.payment_page_reference = attributes[:'payment_page_reference']
      end

      if attributes.key?(:'simulated_status')
        self.simulated_status = attributes[:'simulated_status']
      end

      if attributes.key?(:'ideal_bic')
        self.ideal_bic = attributes[:'ideal_bic']
      end

      if attributes.key?(:'selected_payment_method')
        self.selected_payment_method = attributes[:'selected_payment_method']
      end

      if attributes.key?(:'card_number')
        self.card_number = attributes[:'card_number']
      end

      if attributes.key?(:'card_cvc')
        self.card_cvc = attributes[:'card_cvc']
      end

      if attributes.key?(:'card_expiry_month')
        self.card_expiry_month = attributes[:'card_expiry_month']
      end

      if attributes.key?(:'card_expiry_year')
        self.card_expiry_year = attributes[:'card_expiry_year']
      end

      if attributes.key?(:'card_holder_name')
        self.card_holder_name = attributes[:'card_holder_name']
      end

      if attributes.key?(:'mcc')
        self.mcc = attributes[:'mcc']
      end

      if attributes.key?(:'recipient_details')
        self.recipient_details = attributes[:'recipient_details']
      end

      if attributes.key?(:'pa_res')
        self.pa_res = attributes[:'pa_res']
      end

      if attributes.key?(:'md')
        self.md = attributes[:'md']
      end

      if attributes.key?(:'r_req')
        self.r_req = attributes[:'r_req']
      end

      if attributes.key?(:'c_res')
        self.c_res = attributes[:'c_res']
      end

      if attributes.key?(:'three_ds_session_data')
        self.three_ds_session_data = attributes[:'three_ds_session_data']
      end

      if attributes.key?(:'three_ds_method_data')
        self.three_ds_method_data = attributes[:'three_ds_method_data']
      end

      if attributes.key?(:'three_d_secure_xid')
        self.three_d_secure_xid = attributes[:'three_d_secure_xid']
      end

      if attributes.key?(:'three_d_secure_cavv')
        self.three_d_secure_cavv = attributes[:'three_d_secure_cavv']
      end

      if attributes.key?(:'three_d_secure_eci')
        self.three_d_secure_eci = attributes[:'three_d_secure_eci']
      end

      if attributes.key?(:'three_d_secure_version')
        self.three_d_secure_version = attributes[:'three_d_secure_version']
      end

      if attributes.key?(:'three_d_secure_ds_trans_id')
        self.three_d_secure_ds_trans_id = attributes[:'three_d_secure_ds_trans_id']
      end

      if attributes.key?(:'token')
        self.token = attributes[:'token']
      end

      if attributes.key?(:'payer_id')
        self.payer_id = attributes[:'payer_id']
      end

      if attributes.key?(:'google_analytics_client_id')
        self.google_analytics_client_id = attributes[:'google_analytics_client_id']
      end

      if attributes.key?(:'allowed_parent_frame_domains')
        self.allowed_parent_frame_domains = attributes[:'allowed_parent_frame_domains']
      end

      if attributes.key?(:'descriptor')
        self.descriptor = attributes[:'descriptor']
      end

      if attributes.key?(:'e_wallet_type')
        self.e_wallet_type = attributes[:'e_wallet_type']
      end

      if attributes.key?(:'apple_pay_transaction_identifier')
        self.apple_pay_transaction_identifier = attributes[:'apple_pay_transaction_identifier']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          originating_ip_address == o.originating_ip_address &&
          origin_header == o.origin_header &&
          user_agent == o.user_agent &&
          three_d_secure_challenge_accept_header == o.three_d_secure_challenge_accept_header &&
          three_d_secure_v2_challenge_window_size == o.three_d_secure_v2_challenge_window_size &&
          browser_language == o.browser_language &&
          browser_time_zone_offset == o.browser_time_zone_offset &&
          browser_java_enabled == o.browser_java_enabled &&
          browser_java_script_enabled == o.browser_java_script_enabled &&
          browser_screen_height == o.browser_screen_height &&
          browser_screen_width == o.browser_screen_width &&
          browser_screen_color_depth == o.browser_screen_color_depth &&
          return_url_success == o.return_url_success &&
          return_url_failed == o.return_url_failed &&
          return_url_cancelled == o.return_url_cancelled &&
          webhook_url == o.webhook_url &&
          payment_page_reference == o.payment_page_reference &&
          simulated_status == o.simulated_status &&
          ideal_bic == o.ideal_bic &&
          selected_payment_method == o.selected_payment_method &&
          card_number == o.card_number &&
          card_cvc == o.card_cvc &&
          card_expiry_month == o.card_expiry_month &&
          card_expiry_year == o.card_expiry_year &&
          card_holder_name == o.card_holder_name &&
          mcc == o.mcc &&
          recipient_details == o.recipient_details &&
          pa_res == o.pa_res &&
          md == o.md &&
          r_req == o.r_req &&
          c_res == o.c_res &&
          three_ds_session_data == o.three_ds_session_data &&
          three_ds_method_data == o.three_ds_method_data &&
          three_d_secure_xid == o.three_d_secure_xid &&
          three_d_secure_cavv == o.three_d_secure_cavv &&
          three_d_secure_eci == o.three_d_secure_eci &&
          three_d_secure_version == o.three_d_secure_version &&
          three_d_secure_ds_trans_id == o.three_d_secure_ds_trans_id &&
          token == o.token &&
          payer_id == o.payer_id &&
          google_analytics_client_id == o.google_analytics_client_id &&
          allowed_parent_frame_domains == o.allowed_parent_frame_domains &&
          descriptor == o.descriptor &&
          e_wallet_type == o.e_wallet_type &&
          apple_pay_transaction_identifier == o.apple_pay_transaction_identifier
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [originating_ip_address, origin_header, user_agent, three_d_secure_challenge_accept_header, three_d_secure_v2_challenge_window_size, browser_language, browser_time_zone_offset, browser_java_enabled, browser_java_script_enabled, browser_screen_height, browser_screen_width, browser_screen_color_depth, return_url_success, return_url_failed, return_url_cancelled, webhook_url, payment_page_reference, simulated_status, ideal_bic, selected_payment_method, card_number, card_cvc, card_expiry_month, card_expiry_year, card_holder_name, mcc, recipient_details, pa_res, md, r_req, c_res, three_ds_session_data, three_ds_method_data, three_d_secure_xid, three_d_secure_cavv, three_d_secure_eci, three_d_secure_version, three_d_secure_ds_trans_id, token, payer_id, google_analytics_client_id, allowed_parent_frame_domains, descriptor, e_wallet_type, apple_pay_transaction_identifier].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      new.build_from_hash(attributes)
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.openapi_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        elsif attributes[self.class.attribute_map[key]].nil? && self.class.openapi_nullable.include?(key)
          self.send("#{key}=", nil)
        end
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :Boolean
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        CashFlowsApi.const_get(type).build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end  end
end

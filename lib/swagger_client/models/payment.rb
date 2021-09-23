=begin
#Payment Gateway API

## API Reference Documentation The Payment Gateway API provides an API for creating new payment jobs, refunds and other payment related operations. This service handles extensive validation and conversion for each request, as well as providing a security layer by doing authentication and authorisation checks. ## Signing API calls To assure message consistency and making it hard to execute a man in the middle attack, all messages are signed with a SHA512 hash. This hash is calculated by appending the body data to the API password (password comes first). The calculated hash is converted to a hex-string and send in the header with `Hash: xxxxxx`. If the message body is empty just hash the password.  The gateway has the ability to have 2 passwords available at one time. When altering a password you first create a new second password. If all the systems have migrated to the new password than you can remove the first password. This way you can alter a password without having migration downtime. ## ConfigurationId header If you have been setup to use the gateway you will receive a configuration id. The configuration id identifies your application to the gateway with it's defined setup properies. Beside the hash you will have to supply the configuration id in the html header of each call to the gateway. The header format should look like: `ConfigurationId: xxxxx`. ## Webhooks It is important for a smooth and safe operation of a payment application to implement web hooks. A web hook is an api endpoint you create on your server implementation. This endpoint will be called from the gateway software on status changes of your payment job. This way you avoid having to poll for payment status changes, instead you will be notified of payment jobs for which the status has changed.  The gateway will perform a POST operation at the specified webhook url when the status of a paymentjob changes. For example from `Pending` to `Paid`. The body consist of notifyType, PaymentjobReference and PaymentReference.  The payment application can use the paymentjobReference and check it's status. Typically an internal delivery process is started for the order involved if the status is `Paid` or `Reserved`. The gateway expects a json response with httpstatus 200 OK, confirming the paymentjobreference and paymentreference.  ````json {  paymentJobReference: \"200421017498767380\",  paymentReference: \"200421100461508616\" } ````  When the gateway receives the confirmed paymentjobReference and paymentReference the webhook procedure will end until another status change occurs. If the response does not contain the expected json with a httpstatus 200 OK, or there is no response at all, the webhook call will get repeated at different intervals. ## Populating payment methods in the checkoutpage When you are performing a shop integration there will be a section in the checkout page where the paymentmethods should be presented to the buyer. We provide an api call _SupportedPaymentMethods_ to populate this section.  This call will provide all the available paymentmethods for this checkout, including payment logo's, surcharges etc. By implementing the result data of this call correctly will make the checkout page ready for all future paymentmethods, avoiding having to do development eachtime a new paymentmethod becomes available. ## Creating a basic paymentjob In order to collect money a paymentjob should be created. We assume you have setup paymentmethods in the configuration and a set of redirect urls for a paid, failed or cancelled payment. As a minimum you specify the amount to collect, currency and localisation for the paymentjob. As a response you will receive a redirect link (action link) where you should redirect the browser of the buyer too in order to complete the payment. This minimum requirement to start a paymentjob is in many cases not sufficient. We advise to at least supply the ordernumber and the billingidentity email when creating a paymentjob. Generally speaking, supply all that you know. Without this information, payment lookup and reconciliation of payments will become a hard job if at all possible. ## Direct acquiring f you are PCI-DSS compliant you can use the gateway to perform card acquiring. By direct acquiring we mean that you gather the card information on your servers and create a paymentjob whilst supplying the card information at the start of a payment. If a 3dSecure call is needed the redirectlink will point you to the 3d secure supplier. If the payment is directly approved you can still use the redirectlink but in that case it will point to the defined success url if the card is authorized. ## Reservations and captures If your business requires you to perform (card) reservations (also called authorisations) first and capture the reservations later, the gateway can support this scenario. The ability to first reserve an amount and later capture this amount, can be set in the configuration and corresponding payment method. The default for autoCapture is true. So if you do not set autoCapture to false authorised amounts are always immediatly captured.  Scenario's where you would want to set autoCapture to false are in cases where you can not deliver the goods immediatly. In this scenario you just want to capture the amount at the time you are ready to deliver the goods and in the meantime want to be sure that when the goods arrive you will receive the reserved funds.  So if you have set autoCapture to false you must manually capture the amount via a seperate api call if the paymentjob status has reached the Reserved status. As soon as the paymentjob reaches the status Reserved you can capture the reserved amount. If you do not specify `AmountToCapture` the full reserved amount will be captured. In case of card capturing the full amount is the only option now.  The cookbook to create a reservation/capture scenario is to start paymentjobs as normal, having the configuration setting for the paymentmethod set to autoCapture false value. And then call Capture as soon as the paymentjob status turns into Reserved and you are ready to deliver. ## Refunds  When you want to refund an amount because for example goods are returned you can call the Refunds method to refund an amount. In order to do so you need the paymentjobreference and paymentreference of the payment within the paymentjob that was used to pay an amount. You can not refund more in one call than the amount that was paid using the paymentmethod referenced by the paymentreference. Technically there can be multiple payments in a paymentjob that have brought together the amount paid in total.

OpenAPI spec version: v1
Contact: tech-support@cashflows.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.28-SNAPSHOT
=end

require 'date'

module SwaggerClient
  class Payment
    # A unique reference of this payment.
    attr_accessor :reference

    # The date and time this payment has been created.
    attr_accessor :create_date_time_utc

    # List of the payment method(s) to use.  This list will consist of multiple payment methods in case of a hosted payment, which are then reduced to exactly one payment method,  during a payment. This is done by asking the payer to make a choice what payment method he wants to use.
    attr_accessor :payment_methods

    attr_accessor :status

    attr_accessor :last_error_report

    attr_accessor :abuse_report

    # The amount to collect in this payment in the currency specified in the payment job.  If left empty the entire amountToCollect of the payment job is used upon start of the payment.
    attr_accessor :amount_to_collect

    # The amount which will be added to the originally supplied amount to collect.
    attr_accessor :surcharge_amount

    # The total amount to be paid in this payment in the currency compatible with the selected payment method.  Equal to the amount to collect + surcharge amount, multiplied by the conversion rate.  If null, the total amount has not been converted and the amount to collect + surcharge amount is used instead.
    attr_accessor :converted_total_amount

    attr_accessor :converted_currency

    # The conversion rate used for converting the total amount to the currency compatible with the selected payment  method. If null, the amount to collect has not been converted.
    attr_accessor :conversion_rate

    # The amount that the payer has has paid to the receiver.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture.
    attr_accessor :paid_amount

    # A list of steps executed on this payment.
    attr_accessor :steps

    # Flags that apply to this payment.  They can either not be set or set with a true or false value.
    attr_accessor :flags

    attr_accessor :attributes

    # List of refunds that are or will be executed on this payment.
    attr_accessor :refunds

    # List of captures that are or will be executed on this payment.
    attr_accessor :captures

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'create_date_time_utc' => :'createDateTimeUtc',
        :'payment_methods' => :'paymentMethods',
        :'status' => :'status',
        :'last_error_report' => :'lastErrorReport',
        :'abuse_report' => :'abuseReport',
        :'amount_to_collect' => :'amountToCollect',
        :'surcharge_amount' => :'surchargeAmount',
        :'converted_total_amount' => :'convertedTotalAmount',
        :'converted_currency' => :'convertedCurrency',
        :'conversion_rate' => :'conversionRate',
        :'paid_amount' => :'paidAmount',
        :'steps' => :'steps',
        :'flags' => :'flags',
        :'attributes' => :'attributes',
        :'refunds' => :'refunds',
        :'captures' => :'captures'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'reference' => :'Object',
        :'create_date_time_utc' => :'Object',
        :'payment_methods' => :'Object',
        :'status' => :'Object',
        :'last_error_report' => :'Object',
        :'abuse_report' => :'Object',
        :'amount_to_collect' => :'Object',
        :'surcharge_amount' => :'Object',
        :'converted_total_amount' => :'Object',
        :'converted_currency' => :'Object',
        :'conversion_rate' => :'Object',
        :'paid_amount' => :'Object',
        :'steps' => :'Object',
        :'flags' => :'Object',
        :'attributes' => :'Object',
        :'refunds' => :'Object',
        :'captures' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'payment_methods',
        :'amount_to_collect',
        :'surcharge_amount',
        :'converted_total_amount',
        :'conversion_rate',
        :'paid_amount',
        :'steps',
        :'flags',
        :'refunds',
        :'captures'
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `SwaggerClient::Payment` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `SwaggerClient::Payment`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'reference')
        self.reference = attributes[:'reference']
      end

      if attributes.key?(:'create_date_time_utc')
        self.create_date_time_utc = attributes[:'create_date_time_utc']
      end

      if attributes.key?(:'payment_methods')
        if (value = attributes[:'payment_methods']).is_a?(Array)
          self.payment_methods = value
        end
      end

      if attributes.key?(:'status')
        self.status = attributes[:'status']
      end

      if attributes.key?(:'last_error_report')
        self.last_error_report = attributes[:'last_error_report']
      end

      if attributes.key?(:'abuse_report')
        self.abuse_report = attributes[:'abuse_report']
      end

      if attributes.key?(:'amount_to_collect')
        self.amount_to_collect = attributes[:'amount_to_collect']
      end

      if attributes.key?(:'surcharge_amount')
        self.surcharge_amount = attributes[:'surcharge_amount']
      end

      if attributes.key?(:'converted_total_amount')
        self.converted_total_amount = attributes[:'converted_total_amount']
      end

      if attributes.key?(:'converted_currency')
        self.converted_currency = attributes[:'converted_currency']
      end

      if attributes.key?(:'conversion_rate')
        self.conversion_rate = attributes[:'conversion_rate']
      end

      if attributes.key?(:'paid_amount')
        self.paid_amount = attributes[:'paid_amount']
      end

      if attributes.key?(:'steps')
        if (value = attributes[:'steps']).is_a?(Array)
          self.steps = value
        end
      end

      if attributes.key?(:'flags')
        self.flags = attributes[:'flags']
      end

      if attributes.key?(:'attributes')
        self.attributes = attributes[:'attributes']
      end

      if attributes.key?(:'refunds')
        if (value = attributes[:'refunds']).is_a?(Array)
          self.refunds = value
        end
      end

      if attributes.key?(:'captures')
        if (value = attributes[:'captures']).is_a?(Array)
          self.captures = value
        end
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
          reference == o.reference &&
          create_date_time_utc == o.create_date_time_utc &&
          payment_methods == o.payment_methods &&
          status == o.status &&
          last_error_report == o.last_error_report &&
          abuse_report == o.abuse_report &&
          amount_to_collect == o.amount_to_collect &&
          surcharge_amount == o.surcharge_amount &&
          converted_total_amount == o.converted_total_amount &&
          converted_currency == o.converted_currency &&
          conversion_rate == o.conversion_rate &&
          paid_amount == o.paid_amount &&
          steps == o.steps &&
          flags == o.flags &&
          attributes == o.attributes &&
          refunds == o.refunds &&
          captures == o.captures
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [reference, create_date_time_utc, payment_methods, status, last_error_report, abuse_report, amount_to_collect, surcharge_amount, converted_total_amount, converted_currency, conversion_rate, paid_amount, steps, flags, attributes, refunds, captures].hash
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
        SwaggerClient.const_get(type).build_from_hash(value)
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

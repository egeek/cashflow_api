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
  class PaymentJob
    # A unique reference of this payment job.
    attr_accessor :reference

    # The date and time this payment job has been created.
    attr_accessor :create_date_time_utc

    attr_accessor :type

    # A reference to a trace object which will trace all actions executed on this payment.
    attr_accessor :trace_reference

    # The id of the site or service the payment job is associated with.
    attr_accessor :configuration_id

    # The domain where the request arrived on.
    attr_accessor :domain

    attr_accessor :locale

    # The time zone of the target audience of this payment job.
    attr_accessor :time_zone

    attr_accessor :order

    # The history of updated orders.
    attr_accessor :order_history

    # A reference to the parent payment job.
    attr_accessor :parent_payment_job_reference

    # A list of payment methods (for example iDeal, PayPal, AfterPay) to enable for this request.  If none are supplied, all configured and applicable payment methods will be used.
    attr_accessor :payment_methods_to_use

    # A URL that is shown in the portal to the receiver.  This can be used to store a link to an order in the receiver's order system for easy navigation.
    attr_accessor :display_url

    attr_accessor :currency

    # The amount to collect in this payment job.
    attr_accessor :amount_to_collect

    # The amount collected in this payment job so far.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture.
    attr_accessor :amount_collected

    # The amount that the payer has has paid, which includes surcharge amounts.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture.
    attr_accessor :paid_amount

    # The date and time the total to amount to collect has been paid.  Null if the payment job is not fully paid.
    attr_accessor :paid_date_time_utc

    # The date and time the payment job expires and is no longer valid.
    attr_accessor :expiration_date_time_utc

    # The date and time the payment job is due for processing.  Null if the payment job is not due for processing.
    attr_accessor :due_date_time_utc

    # The date and time of the last update to the payment job.
    attr_accessor :last_update_time_utc

    # The date and time this payment job was processed for the last time.
    attr_accessor :last_processed_time_utc

    attr_accessor :flags

    attr_accessor :attributes

    attr_accessor :payment_status

    # List of payments that are part of this payment job.
    attr_accessor :payments

    attr_accessor :recurrence_criteria

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'create_date_time_utc' => :'createDateTimeUtc',
        :'type' => :'type',
        :'trace_reference' => :'traceReference',
        :'configuration_id' => :'configurationId',
        :'domain' => :'domain',
        :'locale' => :'locale',
        :'time_zone' => :'timeZone',
        :'order' => :'order',
        :'order_history' => :'orderHistory',
        :'parent_payment_job_reference' => :'parentPaymentJobReference',
        :'payment_methods_to_use' => :'paymentMethodsToUse',
        :'display_url' => :'displayUrl',
        :'currency' => :'currency',
        :'amount_to_collect' => :'amountToCollect',
        :'amount_collected' => :'amountCollected',
        :'paid_amount' => :'paidAmount',
        :'paid_date_time_utc' => :'paidDateTimeUtc',
        :'expiration_date_time_utc' => :'expirationDateTimeUtc',
        :'due_date_time_utc' => :'dueDateTimeUtc',
        :'last_update_time_utc' => :'lastUpdateTimeUtc',
        :'last_processed_time_utc' => :'lastProcessedTimeUtc',
        :'flags' => :'flags',
        :'attributes' => :'attributes',
        :'payment_status' => :'paymentStatus',
        :'payments' => :'payments',
        :'recurrence_criteria' => :'recurrenceCriteria'
      }
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'reference' => :'Object',
        :'create_date_time_utc' => :'Object',
        :'type' => :'Object',
        :'trace_reference' => :'Object',
        :'configuration_id' => :'Object',
        :'domain' => :'Object',
        :'locale' => :'Object',
        :'time_zone' => :'Object',
        :'order' => :'Object',
        :'order_history' => :'Object',
        :'parent_payment_job_reference' => :'Object',
        :'payment_methods_to_use' => :'Object',
        :'display_url' => :'Object',
        :'currency' => :'Object',
        :'amount_to_collect' => :'Object',
        :'amount_collected' => :'Object',
        :'paid_amount' => :'Object',
        :'paid_date_time_utc' => :'Object',
        :'expiration_date_time_utc' => :'Object',
        :'due_date_time_utc' => :'Object',
        :'last_update_time_utc' => :'Object',
        :'last_processed_time_utc' => :'Object',
        :'flags' => :'Object',
        :'attributes' => :'Object',
        :'payment_status' => :'Object',
        :'payments' => :'Object',
        :'recurrence_criteria' => :'Object'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'configuration_id',
        :'domain',
        :'time_zone',
        :'order_history',
        :'parent_payment_job_reference',
        :'payment_methods_to_use',
        :'display_url',
        :'amount_collected',
        :'paid_amount',
        :'paid_date_time_utc',
        :'due_date_time_utc',
        :'payments',
      ])
    end
  
    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `CashFlowsApi::PaymentJob` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `CashFlowsApi::PaymentJob`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'reference')
        self.reference = attributes[:'reference']
      end

      if attributes.key?(:'create_date_time_utc')
        self.create_date_time_utc = attributes[:'create_date_time_utc']
      end

      if attributes.key?(:'type')
        self.type = attributes[:'type']
      end

      if attributes.key?(:'trace_reference')
        self.trace_reference = attributes[:'trace_reference']
      end

      if attributes.key?(:'configuration_id')
        self.configuration_id = attributes[:'configuration_id']
      end

      if attributes.key?(:'domain')
        self.domain = attributes[:'domain']
      end

      if attributes.key?(:'locale')
        self.locale = attributes[:'locale']
      end

      if attributes.key?(:'time_zone')
        self.time_zone = attributes[:'time_zone']
      end

      if attributes.key?(:'order')
        self.order = attributes[:'order']
      end

      if attributes.key?(:'order_history')
        if (value = attributes[:'order_history']).is_a?(Array)
          self.order_history = value
        end
      end

      if attributes.key?(:'parent_payment_job_reference')
        self.parent_payment_job_reference = attributes[:'parent_payment_job_reference']
      end

      if attributes.key?(:'payment_methods_to_use')
        if (value = attributes[:'payment_methods_to_use']).is_a?(Array)
          self.payment_methods_to_use = value
        end
      end

      if attributes.key?(:'display_url')
        self.display_url = attributes[:'display_url']
      end

      if attributes.key?(:'currency')
        self.currency = attributes[:'currency']
      end

      if attributes.key?(:'amount_to_collect')
        self.amount_to_collect = attributes[:'amount_to_collect']
      end

      if attributes.key?(:'amount_collected')
        self.amount_collected = attributes[:'amount_collected']
      end

      if attributes.key?(:'paid_amount')
        self.paid_amount = attributes[:'paid_amount']
      end

      if attributes.key?(:'paid_date_time_utc')
        self.paid_date_time_utc = attributes[:'paid_date_time_utc']
      end

      if attributes.key?(:'expiration_date_time_utc')
        self.expiration_date_time_utc = attributes[:'expiration_date_time_utc']
      end

      if attributes.key?(:'due_date_time_utc')
        self.due_date_time_utc = attributes[:'due_date_time_utc']
      end

      if attributes.key?(:'last_update_time_utc')
        self.last_update_time_utc = attributes[:'last_update_time_utc']
      end

      if attributes.key?(:'last_processed_time_utc')
        self.last_processed_time_utc = attributes[:'last_processed_time_utc']
      end

      if attributes.key?(:'flags')
        self.flags = attributes[:'flags']
      end

      if attributes.key?(:'attributes')
        self.attributes = attributes[:'attributes']
      end

      if attributes.key?(:'payment_status')
        self.payment_status = attributes[:'payment_status']
      end

      if attributes.key?(:'payments')
        if (value = attributes[:'payments']).is_a?(Array)
          self.payments = value
        end
      end

      if attributes.key?(:'recurrence_criteria')
        self.recurrence_criteria = attributes[:'recurrence_criteria']
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
          type == o.type &&
          trace_reference == o.trace_reference &&
          configuration_id == o.configuration_id &&
          domain == o.domain &&
          locale == o.locale &&
          time_zone == o.time_zone &&
          order == o.order &&
          order_history == o.order_history &&
          parent_payment_job_reference == o.parent_payment_job_reference &&
          payment_methods_to_use == o.payment_methods_to_use &&
          display_url == o.display_url &&
          currency == o.currency &&
          amount_to_collect == o.amount_to_collect &&
          amount_collected == o.amount_collected &&
          paid_amount == o.paid_amount &&
          paid_date_time_utc == o.paid_date_time_utc &&
          expiration_date_time_utc == o.expiration_date_time_utc &&
          due_date_time_utc == o.due_date_time_utc &&
          last_update_time_utc == o.last_update_time_utc &&
          last_processed_time_utc == o.last_processed_time_utc &&
          flags == o.flags &&
          attributes == o.attributes &&
          payment_status == o.payment_status &&
          payments == o.payments &&
          recurrence_criteria == o.recurrence_criteria
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [reference, create_date_time_utc, type, trace_reference, configuration_id, domain, locale, time_zone, order, order_history, parent_payment_job_reference, payment_methods_to_use, display_url, currency, amount_to_collect, amount_collected, paid_amount, paid_date_time_utc, expiration_date_time_utc, due_date_time_utc, last_update_time_utc, last_processed_time_utc, flags, attributes, payment_status, payments, recurrence_criteria].hash
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

=begin
#Payment Gateway API

## API Reference Documentation The Payment Gateway API provides an API for creating new payment jobs, refunds and other payment related operations. This service handles extensive validation and conversion for each request, as well as providing a security layer by doing authentication and authorisation checks. ## Signing API calls To assure message consistency and making it hard to execute a man in the middle attack, all messages are signed with a SHA512 hash. This hash is calculated by appending the body data to the API password (password comes first). The calculated hash is converted to a hex-string and send in the header with `Hash: xxxxxx`. If the message body is empty just hash the password.  The gateway has the ability to have 2 passwords available at one time. When altering a password you first create a new second password. If all the systems have migrated to the new password than you can remove the first password. This way you can alter a password without having migration downtime. ## ConfigurationId header If you have been setup to use the gateway you will receive a configuration id. The configuration id identifies your application to the gateway with it's defined setup properies. Beside the hash you will have to supply the configuration id in the html header of each call to the gateway. The header format should look like: `ConfigurationId: xxxxx`. ## Webhooks It is important for a smooth and safe operation of a payment application to implement web hooks. A web hook is an api endpoint you create on your server implementation. This endpoint will be called from the gateway software on status changes of your payment job. This way you avoid having to poll for payment status changes, instead you will be notified of payment jobs for which the status has changed.  The gateway will perform a POST operation at the specified webhook url when the status of a paymentjob changes. For example from `Pending` to `Paid`. The body consist of notifyType, PaymentjobReference and PaymentReference.  The payment application can use the paymentjobReference and check it's status. Typically an internal delivery process is started for the order involved if the status is `Paid` or `Reserved`. The gateway expects a json response with httpstatus 200 OK, confirming the paymentjobreference and paymentreference.  ````json {  paymentJobReference: \"200421017498767380\",  paymentReference: \"200421100461508616\" } ````  When the gateway receives the confirmed paymentjobReference and paymentReference the webhook procedure will end until another status change occurs. If the response does not contain the expected json with a httpstatus 200 OK, or there is no response at all, the webhook call will get repeated at different intervals. ## Populating payment methods in the checkoutpage When you are performing a shop integration there will be a section in the checkout page where the paymentmethods should be presented to the buyer. We provide an api call _SupportedPaymentMethods_ to populate this section.  This call will provide all the available paymentmethods for this checkout, including payment logo's, surcharges etc. By implementing the result data of this call correctly will make the checkout page ready for all future paymentmethods, avoiding having to do development eachtime a new paymentmethod becomes available. ## Creating a basic paymentjob In order to collect money a paymentjob should be created. We assume you have setup paymentmethods in the configuration and a set of redirect urls for a paid, failed or cancelled payment. As a minimum you specify the amount to collect, currency and localisation for the paymentjob. As a response you will receive a redirect link (action link) where you should redirect the browser of the buyer too in order to complete the payment. This minimum requirement to start a paymentjob is in many cases not sufficient. We advise to at least supply the ordernumber and the billingidentity email when creating a paymentjob. Generally speaking, supply all that you know. Without this information, payment lookup and reconciliation of payments will become a hard job if at all possible. ## Direct acquiring f you are PCI-DSS compliant you can use the gateway to perform card acquiring. By direct acquiring we mean that you gather the card information on your servers and create a paymentjob whilst supplying the card information at the start of a payment. If a 3dSecure call is needed the redirectlink will point you to the 3d secure supplier. If the payment is directly approved you can still use the redirectlink but in that case it will point to the defined success url if the card is authorized. ## Reservations and captures If your business requires you to perform (card) reservations (also called authorisations) first and capture the reservations later, the gateway can support this scenario. The ability to first reserve an amount and later capture this amount, can be set in the configuration and corresponding payment method. The default for autoCapture is true. So if you do not set autoCapture to false authorised amounts are always immediatly captured.  Scenario's where you would want to set autoCapture to false are in cases where you can not deliver the goods immediatly. In this scenario you just want to capture the amount at the time you are ready to deliver the goods and in the meantime want to be sure that when the goods arrive you will receive the reserved funds.  So if you have set autoCapture to false you must manually capture the amount via a seperate api call if the paymentjob status has reached the Reserved status. As soon as the paymentjob reaches the status Reserved you can capture the reserved amount. If you do not specify `AmountToCapture` the full reserved amount will be captured. In case of card capturing the full amount is the only option now.  The cookbook to create a reservation/capture scenario is to start paymentjobs as normal, having the configuration setting for the paymentmethod set to autoCapture false value. And then call Capture as soon as the paymentjob status turns into Reserved and you are ready to deliver. ## Refunds  When you want to refund an amount because for example goods are returned you can call the Refunds method to refund an amount. In order to do so you need the paymentjobreference and paymentreference of the payment within the paymentjob that was used to pay an amount. You can not refund more in one call than the amount that was paid using the paymentmethod referenced by the paymentreference. Technically there can be multiple payments in a paymentjob that have brought together the amount paid in total.

OpenAPI spec version: v1
Contact: tech-support@cashflows.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.28-SNAPSHOT
=end

# load the gem
require 'swagger_client'

# The following  was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

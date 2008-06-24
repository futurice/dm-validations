module DataMapper
  module Validate

    ##
    #
    # @author Dirkjan Bussink
    # @since  0.9
    class PrimitiveValidator < GenericValidator

      def initialize(field_name, options={})
        super
        @field_name, @options = field_name, options
      end

      def call(target)
        value = target.validation_property_value(@field_name)
        property = target.validation_property(@field_name)
        return true if value.nil? || value.kind_of?(property.primitive)

        error_message = @options[:message] || default_error(property)
        add_error(target, error_message, @field_name)

        false
      end

      protected

      def default_error(property)
        "%s must be of type #{property.primitive.to_s}".t(Extlib::Inflection.humanize(@field_name))
      end

    end # class PrimitiveValidator

    module ValidatesIsPrimitive

      ##
      # Validates that the specified attribute is of the correct primitive type.
      #
      # @example [Usage]
      #   require 'dm-validations'
      #
      #   class Person
      #     include DataMapper::Resource
      #
      #     property :birth_date, Date
      #
      #     validates_is_primitive :required_attribute
      #
      #     # a call to valid? will return false unless
      #     # the birth_date is something that can be properly
      #     # casted into a Date object.
      #   end
      def validates_is_primitive(*fields)
        opts = opts_from_validator_args(fields)
        add_validator_to_context(opts, fields, DataMapper::Validate::PrimitiveValidator)
      end

    end # module ValidatesPresent
  end # module Validate
end # module DataMapper
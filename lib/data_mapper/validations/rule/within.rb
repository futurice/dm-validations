# -*- encoding: utf-8 -*-

require 'data_mapper/validations/rule'

module DataMapper
  module Validations
    class Validator

      module Within

        # TODO: DRY this up (also implemented in Validator)
        def self.validators_for(attribute_name, options)
          Array(new(attribute_name, options))
        end

        # TODO: move options normalization into the validator macros
        def self.new(attribute_name, options)
          set = options.fetch(:set)

          if set.is_a?(::Range)
            Within::Range.new(attribute_name, options)
          else
            Within::Set.new(attribute_name, options)
          end
        end

      end # module Within

    end # class Validator
  end # module Validations
end # module DataMapper

require 'data_mapper/validations/rule/within/range'
require 'data_mapper/validations/rule/within/set'
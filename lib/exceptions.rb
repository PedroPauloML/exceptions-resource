module Exceptions
  class Base < StandardError
    attr_accessor :object, :type

    # starts a new instance with an object
    # @param [Object] object
    def initialize object
      self.object = object
    end

    # standard error for Models
    # @param [ActiveRecord::Base] object
    # @return [Exceptions::Base]
    def self.build object
      exception = new object
      return exception
    end

    # return if is as simple error
    # @return [Boolean]
    def simple?
      self.class.name.demodulize.tableize.singularize == "simple"
    end

    # return if is as model error
    # @return [Boolean]
    def model?
      self.class.name.demodulize.tableize.singularize == "model"
    end   
  end

  class Model < Base
    # for model errors this method build a hash with all necessary information
    # @return [String] json string
    def error
      self.is_nested? ? self.build_nested : self.build_normal
    end

    def build_nested
      { 
        error: { 
          model: self.nested_model.camelcase, 
          model_human: self.nested_model_human,
          field: "#{self.nested_model}[#{self.nested_attr}]",
          attribute: self.nested_attr, 
          attribute_human: self.nested_attr_human,
          message: self.message,
          full_message: "#{self.nested_attr_human} #{self.message}"
        } 
      }
    end

    def build_normal
      { 
        error: { 
          model: self.model.camelcase,
          model_human: self.model_human,
          field: "#{self.model}[#{self.attribute}]",
          attribute: self.attribute, 
          attribute_human: self.attribute_human, 
          message: self.message,
          full_message: "#{self.attribute_human} #{self.message}"
        } 
      }
    end

    # return what model is
    # @return [String]
    def model
      self.object.class.name.demodulize.tableize.singularize.downcase
    end

    def attribute
      self.object.errors.first[0]
    end

    def model_human
      self.object.class.model_name.human.demodulize.tableize.singularize.downcase
    end

    def attribute_human
      self.object.class.human_attribute_name(self.object.errors.first.attribute)
    end

    # return the error message
    # @return [String]
    def message 
      "#{self.object.errors.first.message}"
    end

    def status
      422
    end

    def is_nested?
      attribute = self.object.errors.first[0]

      if attribute.to_s.split(".").size > 1
        self.object.respond_to?(attribute) ? false : true
      else
        false
      end
    end

    def nested_model
      self.object.errors.first.attribute.to_s.split(".").first.singularize.downcase
    end

    def nested_model_human
      self.nested_model.capitalize.constantize.model_name.human
    end

    def nested_attr
      self.object.errors.first.attribute.to_s.split(".").last
    end

    def nested_attr_human
      self.nested_model.capitalize.constantize.human_attribute_name(self.nested_attr)
    end
  end

  class Resource < Base
    # for standard errors this method build a hash
    # @return [String] json string
    def error
      {
        error: { 
          model: self.object["model"],
          model_human: self.object["model_human"],
          attribute: self.object["attribute"],
          attribute_human: self.object["attribute_human"],
          field: self.object["field"],
          message: self.object["message"],
          full_message: "#{self.object["full_message"]}"
        } 
      }
    end

    # return the error message
    # @return [String]
    def message
      self.error[:message]
    end

    # return the error status
    def status
      406
    end
  end

  class Simple < Base
    attr_accessor :status


    # for standard errors this method build a hash
    # @return [String] json string
    def error
      { 
        error: { 
          message: self.object[:message],
          full_message: "#{self.object[:field]} #{self.object[:message]} ",
          field: self.object[:field]
        } 
      }
    end

    # return the error message
    # @return [String]
    def message
      self.object[:message]
    end

    # return the error status
    def status
      406
    end
  end

  # represents the simple errors
  class UnauthorizedApplication < Base
    attr_accessor :status


    # for standard errors this method build a hash
    # @return [String] json string
    def error
      { 
        error: { 
          message: self.object[:message]
        } 
      }
    end

    # return the error message
    # @return [String]
    def message
      self.object[:message]
    end

    # return the error status
    def status
      401
    end
  end
end

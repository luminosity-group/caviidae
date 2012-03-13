require 'databasedotcom'

module Databasedotcom
  class Client
  
    alias :original_create :create
    def create(class_or_classname, object_attrs)
      new_object = original_create(class_or_classname, object_attrs)
      store(new_object)
      new_object
    end

    def store(sobject)
      created << sobject
    end

    def cleanup
      created.each do |sobject|
        sobject.delete
        sobject = nil
      end
      @created = []
    end

    def created
      @created ||= []
    end
  
  end
end

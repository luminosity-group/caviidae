require 'databasedotcom'

module Databasedotcom
  class Client
  
    # Maybe there's a better way to do this but overriding the method should
    # work
    def create(class_or_classname, object_attrs)
      class_or_classname = find_or_materialize(class_or_classname)
      json_for_assignment = coerced_json(object_attrs, class_or_classname)
      result = http_post("/services/data/v#{self.version}/sobjects/#{class_or_classname.sobject_name}", json_for_assignment)
      new_object = class_or_classname.new
      JSON.parse(json_for_assignment).each do |property, value|
        set_value(new_object, property, value, class_or_classname.type_map[property][:type])
      end
      id = JSON.parse(result.body)["id"]
      set_value(new_object, "Id", id, "id")
      store(new_object)
      puts "Created"
      new_object
    end

    def store(sobject)
      @created ||= []
      @created << sobject
    end

    def cleanup
      @created.each do |sobject|
        sobject.delete
      end
      @created = []
    end
  
  end
end

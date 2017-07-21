module CWL 
	require 'json'	


    # Throw error if users input does not match required types from spec
    def self.check_types spec, input
        type = spec['type']
        if ["string", "array"].include?(type)
            if type.capitalize != input.class.name
                raise TypeError.new "Type should be type #{type}"
            else
                return true
            end
        else
            if spec.key?('anyOf')
                puts 'TODO: Implement check anyOf'
            end
            if spec.key?('$ref')
                puts 'TODO: Implement check of refs'
            end 
        end
    end#check_types



    # Workflow cass dynamically creates methods to write, read, and get help on
    # all the available properties of the CWL spec
	class Workflow
	    json_wf = JSON.parse(File.open('./cwl_spec.json').read)
        #Get properties subtree
	    properties = json_wf['properties'].tap { |hs| hs.delete('class') }
        #Which elements are required (for validation)
        required = json_wf['required']
        
        # Setup property read, write, and eh? methods
        #e.g. property #=> outputs   |.  spec #=> {:type => 'string', :description => 'output must be string'}
	    properties.each do |property, spec| 
            desc = spec['description']
            
            # Create a 'read' property value
            define_method "#{property}".to_sym do |*my_arg|
                p instance_variable_get("@#{property}")
            end

            # Create a 'write' property value. Check conforms to type 
			define_method "#{property}=".to_sym do |*my_arg|
                input = my_arg[0]
                begin
                    CWL.check_types spec, input
                    instance_variable_set("@#{property}", input)
                    p self
                rescue TypeError, Exception => e
                    p "#{e.class}: #{e.message}"
                end
	    	end

            # Little help method - not a Ruby convention format...
            define_method "#{property}?".to_sym do |*my_arg|
                p "#{spec['description']}"
            end     
    	end

       # Return list of available options
	   def options 
	     return self.methods - Object.instance_methods
	   end

	end#Workflow
end#CWL


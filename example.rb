require './cwl'

workflow = CWL::Workflow.new

# View what fields are available
workflow.options

#TODO: View what fields are required
# workflow.required

# Describe what a property is e.g. What are 'outputs' in CWL?
workflow.outputs?

# Set id
workflow.id = ['1', '2']
#=> "TypeError: Type should be type string"

workflow.id = '1'
#=> #<CWL::Workflow:0x007fcdb515eca0 @id="1">


#workflow.expression=['these are my outputs']
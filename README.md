Ruby module to help construct CWL specs from the latest schema. 

### Usage

```
require './cwl'

workflow = CWL::Workflow.new

# View what fields are available
workflow.options
#=> [:expression, :expression=, :expression?, :outputs, :outputs=, :outputs?, :id, :id=, :id?, :inputs, :inputs=, :inputs?, :requirements, :requirements=, :requirements?, :hints, :hints=, :hints?, :label, :label=, :label?, :doc, :doc=, :doc?, :cwlVersion, :cwlVersion=, :cwlVersion?, :options] 


# Use '?' notation to describe what a property is e.g. What are 'outputs' in CWL?
workflow.outputs?
#=> "Defines the parameters representing the output of the process.  May be\n\nused to generate and/or validate the output object." 

# Set id with bad input
workflow.id = ['1', '2']
#=> "TypeError: Type should be type string"

# Setup id with good input
workflow.id = '1'
#=> #<CWL::Workflow:0x007fcdb515eca0 @id="1">


#TODO: View what fields are required
# workflow.required

#TODO: Render out 
# workflow.render('outfile.cwl')

```


module Glimmer
  module LibUI
    module ContentBindable
      # Data-binds the generation of nested content to a model/property (in binding args)
      # consider providing an option to avoid initial rendering without any changes happening
      def bind_content(*binding_args, &content_block)
        # TODO in the future, consider optimizing code by diffing content if that makes sense
        content_binding_work = proc do |*values|
          children.dup.each { |child| child.destroy }
          content(&content_block)
        end
        model_binding_observer = Glimmer::DataBinding::ModelBinding.new(*binding_args)
        content_binding_observer = Glimmer::DataBinding::Observer.proc(&content_binding_work)
        content_binding_observer.observe(model_binding_observer)
        content_binding_work.call # TODO inspect if we need to pass args here (from observed attributes) [but it's simpler not to pass anything at first]
      end
    end
  end
end

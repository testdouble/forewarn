require "forewarn/triggers_warning"

module Forewarn
  class OverridesMethods
    def override!(methods)
      triggers_warning = TriggersWarning.new
      methods.each do |method|
        real_method = method.method
        real_method.owner.send(:define_method, real_method.name) do |*args, &blk|
          triggers_warning.trigger!(method)
          real_method.bind(self).call(*args, &blk)
        end
      end
    end
  end
end

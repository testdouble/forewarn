require 'pry'

module WarnOfUse
  class AddsWarning
    def add(method)
      method.owner.send(:define_method, method.name) do |*args, &blk|
        warn "OHNOOOOO"
        method.bind(self).call(*args, &blk)
      end
    end
  end
end

binding.pry

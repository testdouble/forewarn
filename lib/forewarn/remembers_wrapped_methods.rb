module Forewarn
  class RemembersWrappedMethods
    @@wrapped_methods = []

    def remember!(methods)
      @@wrapped_methods += methods
    end

    def remembered_methods
      @@wrapped_methods
    end

    def forget!
      @@wrapped_methods = []
    end
  end
end


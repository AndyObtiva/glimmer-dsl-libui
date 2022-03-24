module Glimmer
  class << self
    def included(klass)
      klass.extend(Glimmer)
    end
  end
end

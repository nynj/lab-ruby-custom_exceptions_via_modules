module Errors
  Error = Module.new

  class NotFoundError < StandardError
    include Error
  end

  class PermissionError < StandardError
    include Error
  end
  
end
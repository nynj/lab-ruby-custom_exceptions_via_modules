include Errors

# show using ruby Module as customer exception def
# all app exceptions are "tagged" with the Error module, allowing catch-all rescues
class Test
  
  def find 
    raise NotFoundError, 'blah not found'
  end

  def gen 
    raise PermissionError, 'blah permission'
  end
  
  def get
    ls = [lambda{ find }, lambda{ gen }, lambda {raise StandardError}]
    
    ls.each_with_index { |x,i|
      puts i
      begin 
        x.call
      rescue NotFoundError => e
        puts "not found error - #{e}"
      rescue Error => e
        puts "general app error found - #{e}" 
      rescue  => e
        puts "system error - #{e}"
      end
    }
  end
  
end
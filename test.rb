include Errors

# using ruby Module for custom exception definitions
# per http://globaldev.co.uk/2013/09/ruby-tips-part-3/
# all app exceptions are "tagged" with the Error module, allowing catch-all rescues
class Test
  def get
    puts '------------'

    ls = [
      lambda{ raise NotFoundError, 'blah not found' },
      lambda{ raise PermissionError, 'blah permission' },
      lambda {raise StandardError},
      lambda {raise NoMethodError}
      ]
    
    ls.each_with_index { |x,i|
      puts i
      # catch block for app catch-all and system catch-all
      begin 
        # catch specific errors
        begin
          x.call
        rescue NotFoundError => e
          puts "not found error- '#{e}' - class: #{e.class}- trace: #{e.backtrace[0.30]}..." 
        rescue NoMethodError => e
          # by extending Error, original exception info preserved but will be caught by 'Error' rescue
          e.extend Error
          raise e, "#{e.message} - custom message appended on end", e.backtrace
        end
      rescue Error => e
        puts "general app error - '#{e}' - class: #{e.class}- trace: #{e.backtrace[0.30]}..." 
      rescue  => e
        puts "system error- '#{e}' - class: #{e.class}- trace: #{e.backtrace[0.30]}..." 
      end
    }
    puts '------------'
  end
  
end
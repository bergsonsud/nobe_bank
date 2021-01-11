class TaxCalculator
	def initialize(value, date, type_transaction)
		@value = value
		@date = date	
		@type_transaction = type_transaction	
	end


	def calc_tax				
		if @value.to_f>0 and (@type_transaction == 'transfer' or @type_transaction == '3')
			return tax+extra
		else
			return 0
		end
	end


	def tax
	    #helper days = {0 => "Sunday",1 => "Monday", 2 => "Tuesday",3 => "Wednesday",4 => "Thursday",5 => "Friday",6 => "Saturday"}
	    today = @date.wday
	    hour = @date.hour
	    
	    if today.between?(1,6) and hour.between?(9,18)
	    	return 5
	    else
	    	return 7
	    end
	end	

	def extra	    
	    if @value <=1000
	    	return 0
	    else
	    	return 10
	    end
	end		
end
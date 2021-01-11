class TaxCalculator
  def initialize(value, date, type_transaction, type_transfer)
    @value = value
    @date = date
    @type_transaction = type_transaction
    @type_transfer = type_transfer
  end

  def calc_tax
    if (@value.to_f > 0) && ((@type_transaction == 'transfer') || (@type_transaction == '3'))
      tax + extra
    else
      0
    end
  end

  def tax
    # helper days = {0 => "Sunday",1 => "Monday", 2 => "Tuesday",3 => "Wednesday",4 => "Thursday",5 => "Friday",6 => "Saturday"}
    today = @date.wday
    hour = @date.hour

    if today.between?(1, 6) && hour.between?(9, 18)
      5
    else
      7
    end
  end

  def extra
    if @value <= 1000
      0
    else
      10
    end
  end
end

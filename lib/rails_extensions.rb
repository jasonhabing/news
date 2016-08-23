class Array
  
  def sum
    return self.inject(0){|accum, i| accum + i }
  end

  def mean
    return self.sum / self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum + (i - m) ** 2 }
    return sum / (self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

end


class Float
  def sqrt; Math.sqrt(self); end
  def sin; Math.sin(self); end
  def cos; Math.cos(self); end
  def tan; Math.tan(self); end
  def log10; Math.log10(self); end
end

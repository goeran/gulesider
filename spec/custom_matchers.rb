Spec::Matchers.define :be_nil_or_empty do 
  match do |obj|
    obj == nil or obj.empty?
  end
end

Spec::Matchers.define :have_values_for do |expected|
  match do |actual|
    have_values actual, expected
  end
  
  def have_values actual, expected
    expected.each do |expected_key|
      val = actual[expected_key]
      if val == nil or val.strip == ""
        @missing_key = expected_key
        return false
      end
    end
    return true
  end
  
  failure_message_for_should do |actual|
      "expected value for: hash[#{@missing_key}]"
  end
end
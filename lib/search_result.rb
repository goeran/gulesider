class SearchResult < Hash
  def initialize another_hash
    merge! another_hash
  end
  
  def company?
    self[:company] == true
  end
  
  def person?
    self[:person] == true
  end
end
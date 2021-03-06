class Hash

  # Merge the values of this hash with those from another, setting all values
  # to be arrays representing the values from both hashes.
  #
  #   { :a=>1, :b=>2 }.collate :a=>3, :b=>4, :c=>5
  #   #=> { :a=>[1,3], :b=>[2,4], :c=>[5] }
  #
  # CREDIT: Tilo Sloboda
  # CREDIT: Gavin Kistner (Phrogz)

  def collate(other_hash)
    h = Hash.new
    # Prepare, ensuring every existing key is already an Array
    each do |key, value|
      if value.is_a?(Array)
        h[key] = value
      else
        h[key] = [value]
      end
    end
    # Collate with values from other_hash
    other_hash.each do |key, value|
      if h[key]
        if value.is_a?(Array)
          h[key].concat(value)
        else
          h[key] << value
        end
      elsif value.is_a?(Array)
        h[key] = value
      else
        h[key] = [value]
      end
    end
    #each{ |key, value| value.uniq! } if options[ :uniq ]
    h
  end

  # The same as #collate, but modifies the receiver in place.

  def collate!(other_hash)
    result = self.collate(other_hash)
    self.replace(result)
  end

  # Old version.
  #def collate!(other_hash)
  #  # Prepare, ensuring every existing key is already an Array
  #  each do |key, value|
  #    if value.is_a?(Array)
  #      self[key] = value
  #    else
  #      self[key] = [value]
  #    end
  #  end
  #  # Collate with values from other_hash
  #  other_hash.each do |key, value|
  #    if self[key]
  #      if value.is_a?(Array)
  #        self[key].concat( value )
  #      else
  #        self[key] << value
  #      end
  #    elsif value.is_a?(Array)
  #      self[key] = value
  #    else
  #      self[key] = [value]
  #    end
  #  end
  #  #each{ |key, value| value.uniq! } if options[ :uniq ]
  #  self
  #end

end


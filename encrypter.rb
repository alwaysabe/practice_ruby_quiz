class Encrypter
  attr_accessor :cipher_text

  def sanitize(str)
    str.upcase.gsub(/[^A-Z]/, '')
  end

  def pack(str)
    str += 'X' * ((str.size / 5.0).ceil * 5 - str.size)
  end

  def to_numbers(message)
    numbers = []
    message.each_byte { |c| numbers << c - 64 unless c == 32 }
    numbers
  end

  def combiner(value, key)
    encrypted = []
    return encrypted unless value.size == key.size
    value.size.times do |i|
      e = value[i] + key[i]
      e -= 26 if e > 26
      encrypted << e
    end
    encrypted
  end

  def numbered(msg)
    self.to_numbers(self.pack(self.sanitize(msg)))
  end

  def encrypt(data, key)
    data_numbered = self.numbered(data)
    key_numbered = self.numbered(key)
    @cipher_text = self.combiner(data_numbered, key_numbered).map { |n| (n + 64).chr }.join
    self.to_s
  end

  def decrypt(key)
    # decrypt -> @cipher_text
  end
  
  def to_s
    packed_text = self.pack(@cipher_text)
    s = ''
    segments = (packed_text.size / 5.0).ceil
    segments.times do |i|
      s += "#{packed_text[i*5, 5]} "
    end
    s.strip
  end
end

if __FILE__ == $0 then
  sample_key = 'AAAAA AAAAA AA'
  ss="hello world"
  ee=Encrypter.new
  puts ee.encrypt('abe sam thomas',sample_key)
  puts ee.encrypt('Code in Ruby, live longer!', 'DWJXH YRFDG TMSHP UURXJ')
end

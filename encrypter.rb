class Encrypter

    def sanitise(str)
        str = str.upcase.gsub(/[^A-Z]/,"")
        return str
    end
    def pack5(str)
        count=1
        pack_str=""
        str.each_char do |x|
            if count%5 ==0 && count !=0
                pack_str = pack_str+x+" "
            else 
                pack_str = pack_str+x
            end
        count+=1
        end
        return pack_str.strip
    end
    def to_num(message)
        num_message=[]
        message.each_char do |char|
            num_message.push(char[0]-64) if char[0] !=32
        end
        return num_message
    end
    def combiner(value, key)
        encrypted_value =[]
        if value.size == key.size
            for  i in 0..(value.size - 1)
                if value[i] + key[i] > 26
                    encrypted_value.push(value[i] + key[i] - 26)
                else
                    encrypted_value.push(value[i] + key[i])
                end
            end
        end
        return encrypted_value
    end
    def encrypt_data(data, key)
        
        sanitised = sanitise(data)
        packed = pack5(sanitised)
        value_num = to_num(packed)
        key_num = to_num(pack5(key))
        if value_num.size == key_num.size
            encrypted_num = combiner(value_num, key_num)     
        end
        encrypted_string_tmp = ''
        encrypted_num.each do |x|
            encrypted_string_tmp = encrypted_string_tmp+(x+64).chr
        end
        encrypted_string = pack5(encrypted_string_tmp)
        puts encrypted_string_tmp
        return encrypted_string

    end
    def decrypt_data()
    end
end
sample_key = 'AAAAA AAAAA AA'
ss="hello world"
ee=Encrypter.new
#puts ee.pack5(ss)
#puts ee.to_num('ABCDE ZYXWV')
puts ee.encrypt_data('abe sam thomas',sample_key)

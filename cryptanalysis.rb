class Array
  def rotate(n=1)
    n.times { self.push(self.shift) }
    self
  end
end

def caesar_encrypt(plain_text, slide = 13)
  crypt_alpha = ('a'..'z').to_a.rotate(slide % 26).join
  return encrypt(plain_text, crypt_alpha)
end

def caesar_decrypt(cipher_text, slide = 13)
  crypt_alpha = ('a'..'z').to_a.rotate(slide % 26).join
  return decrypt(cipher_text, crypt_alpha)
end

def encrypt(plain_text, alphabet)
  plain_text.downcase.tr(('a'..'z').to_a.join + ' ', alphabet + ' ')
end

def decrypt(cipher_text, alphabet)
  cipher_text.downcase.tr(alphabet + ' ', ('a'..'z').to_a.join + ' ')
end

Model = [1.1022717747569128, -1.2539935875616006, -1.0715412114558136, 0.38719776947991313, 1.6845307000026097, -0.7395933064620372, -0.8554740185121767, 1.1968470166179053, 0.8013343423198935, -5.039898589649604, -1.7287413912185645, 0.12571441052969412, -0.7597030032711771, 0.8211626750437087, 0.9027128482015736, -1.6177990626724998, -6.749308461295249, 0.1998478612902792, 0.6214967405755889, 1.3658406631655162, -0.546191980118989, -2.6368337320368367, -0.4744424032799319, -6.230841372361, -1.28104218528319, -6.749308461295249]

def score_decrypt(decrypt_string,model_array)
  decrypt_string.downcase.each_char.select {|c| ('a'..'z').include? c}.reduce(0) { |memo,char| memo += model_array[char.ord - 'a'.ord] }
end

def find_top_scores(array_of_decrypts,model_array,num_top)
  scores = array_of_decrypts.map { | d | [d,score_decrypt(d,model_array)]}
  scores.sort {|a,b| b.last <=> a.last }.first(num_top)
end

def make_keyword_alphabet(keyword)
  unique_keyword = keyword.downcase.each_char.to_a.select {|c|  ('a'..'z').include? c }.to_a.uniq.join
  new_alpha = unique_keyword + ('a'..'z').to_a.reject {|c| unique_keyword.include? c }.join
end

cipher = "vkrimtgterlbl bl yng tgw xqvbmbgz. vhfinmxkl ftdx bm xoxg uxmmxk!"

puts cipher
26.times do |i|
  puts i
  puts caesar_decrypt(cipher,i)
end

decrypts = []
26.times do |i|
  decrypts << caesar_decrypt(cipher,i)
  puts i
  puts decrypts.last
  puts
end

best_decrypts = find_top_scores(decrypts,Model,5)
best_decrypts.each do | decrypt,score |
  puts score
  puts decrypt
end
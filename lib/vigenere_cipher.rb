class VigenereCipher
  ALPHABET = ('a'..'z').to_a

  attr_reader :key

  def initialize(key=generate_key)
    validate(key)
    @key = key
  end

  def encode(plaintext)
    plaintext
      .gsub(/[a-z]/)
      .with_index { |letter, idx| encode_letter(letter, idx) }
  end

  def decode(ciphertext)
    ciphertext
      .gsub(/[a-z]/)
      .with_index { |letter, idx| decode_letter(letter, idx) }
  end

  private

  def validate(key)
    raise ArgumentError, 'Bad key' unless key =~ /\A[a-z]+\z/
  end

  def generate_key
    100.times.map { ALPHABET.sample }.join
  end

  def encode_letter(letter, idx)
    shift_letter(letter, shift_at(idx))
  end

  def decode_letter(letter, idx)
    shift_letter(letter, -shift_at(idx))
  end

  def shift_letter(letter, shift)
    shifted_place = ALPHABET.index(letter) + shift
    ALPHABET[shifted_place % 26]
  end

  def shift_at(idx)
    ALPHABET.index(key[idx % key.length])
  end
end
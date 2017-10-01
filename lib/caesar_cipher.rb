class Cipher
  attr_reader :shift, :alphabet

  def initialize(shift = 4)
    validate(shift)

    @shift = shift
    @alphabet = ('a'..'z').to_a
  end

  def encode(plaintext)
    plaintext.gsub(/[a-z]/) { |letter| encode_letter(letter) }
  end

  def decode(ciphertext)
    ciphertext.gsub(/[a-z]/) { |letter| decode_letter(letter) }
  end

  private

  def validate(shift)
    raise ArgumentError, 'Not a valid shift.' unless shift.is_a? Fixnum
  end

  def encode_letter(letter)
    encoded_place = (letter_to_place(letter) + shift) % 26
    alphabet[encoded_place]
  end

  def decode_letter(letter)
    decoded_place = (letter_to_place(letter) - shift + 26) % 26
    alphabet[decoded_place]
  end

  def letter_to_place(letter)
    alphabet.index(letter)
  end
end
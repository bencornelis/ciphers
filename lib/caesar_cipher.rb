class CaesarCipher
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
    shift_letter(letter, shift)
  end

  def decode_letter(letter)
    shift_letter(letter, -shift)
  end

  def shift_letter(letter, shift_amount)
    shifted_place = letter_to_place(letter) + shift_amount
    alphabet[shifted_place % 26]
  end

  def letter_to_place(letter)
    alphabet.index(letter)
  end
end
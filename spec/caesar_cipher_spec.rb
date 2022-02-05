require './mini_projects/caesar_cipher'

describe Caesar do
  describe '#caesar_cipher' do
    it 'returns an empty string with an empty input message' do
      expect(Caesar.caesar_cipher('', rand(26))).to eql('')
    end
    it 'returns the same input message with a shift of 0' do
      expect(Caesar.caesar_cipher('Hello', 0)).to eql('Hello')
    end
    it 'returns an encrypted one-word message' do
      expect(Caesar.caesar_cipher('Hello', 1)).to eql('Ifmmp')
    end
    it 'returns an encrypted multi-word message' do
      expect(Caesar.caesar_cipher('What a string!', 5)).to eql('Bmfy f xywnsl!')
    end
    it 'does not alter non-alphabetic symbols' do
      expect(Caesar.caesar_cipher('./,_0123456789!?', rand(26))).to eql('./,_0123456789!?')
    end
    it 'returns the same encrypted message with a shift difference of 26' do
      expect(Caesar.caesar_cipher('Hello', 3)).to eql(Caesar.caesar_cipher('Hello', 3 + 26))
    end
  end
end

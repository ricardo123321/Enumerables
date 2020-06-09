require_relative '../enumerables.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr_num) { [1, 2, 5, 4] }
    let(:arr_str) { %w[a b c] }

    it 'Print all the numbers' do
      expect { arr_num.my_each { |n| print n } }.to output('1254').to_stdout
    end
    it 'Print all the characters' do
      expect { arr_str.my_each { |c| print c, ' -- ' } }.to output('a -- b -- c -- ').to_stdout
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end
end
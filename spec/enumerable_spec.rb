require_relative '../enumerables.rb'

describe Enumerable do

  describe '#my_each' do
    let(:arr_num) { [1, 2, 3, 4] }
    let(:arr_str) { %w[a b c] }

    it 'Print all the numbers' do
      expect { arr_num.my_each { |n| print n } }.to output('1234').to_stdout
    end
    it 'Print all the characters' do
      expect { arr_str.my_each { |c| print c, ' -- ' } }.to output('a -- b -- c -- ').to_stdout
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    let(:arr_num) { [1, 2, 3, 4] }
    let(:arr_str) { %w[a b c] }
    let(:vowels) { %w[a e i o u] }
    it 'Print all the numbers with index bigger than 2' do
      expect { arr_num.my_each_with_index { |n,index| print [n,index] if n > 2 }}.to output('[3, 2][4, 3]').to_stdout
    end 
    it 'print works with its index that have vowels' do
      expect { arr_str.my_each_with_index { |n,index| print [n,index] if vowels.include? n }}.to output('["a", 0]').to_stdout
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end

  describe '#my_select' do
     
end

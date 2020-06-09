require_relative '../enumerables.rb'

describe Enumerable do

    let(:array_1) {[1, 2, 3, 4, 5]}
    let(:array_2) {[2, 4, 6]}
    let(:array_3) {['dog', 'door', 'road', 'blade']}
    let(:array_4) {[2, nil, false]}

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
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:arr_str) { %w[a b c] }
    let(:vowels) { %w[a e i o u] }
    it 'Select the even numbers' do
      expect(arr_num.my_select { |num| (num % 2).zero? }).to include(2, 4)
    end
    it 'Select the multiples of three' do
      expect(arr_str.my_select { |str| vowels.include? str }).to include("a")
    end
    it 'Return enumerator when no block is given' do
      expect(arr_num.my_select).to be_an Enumerator
    end
  end

  describe '#my_any?' do
  it "returns true if the condition holds for any elements" do
     expect(array_1.my_any?(&:even?)).to eql(true)
   end
  it 'returns true if condition does not hold for any elements' do
     expect(array_3.my_any?(/b/)).to eql(true)
   end
   it 'returns false if condition holds for any elements' do
    expect(array_4.my_any?(1)).to eql(false)
  end

end

describe '#my_none?' do
it 'returns true if the condition does not hold for any elements' do
  expect(array_2.my_none?(String)).to eql(true)
end
it 'returns false if condition holds for any elements' do
  expect(array_1.my_none?(&:even?)).to eql(false)
end
end
describe '#my_map' do
it 'returns the modified array performed the operation in the block on each element' do
  expect(array_1.my_map { |element| element * 2 }).to eql([2, 4, 6, 8, 10])
end
it 'returns the modified array performed the operation in the block on each element' do
  expect(array_3.my_map { |word| word + "?" }).to eql(['dog?', 'door?', 'road?', 'blade?'])
end
end

describe '#my_inject' do
it 'returns the result of operation performed on each element in
the array with given argument as parameter.' do
  expect(array_2.my_inject(10) { |sym, item| sym + item }).to eql(22)
end
end

end

# frozen_string_literal: true

# describe ActiveRest::Base do
#   before(:all) do
#     Object.const_set(
#       'TestClass',
#       Class.new(ActiveRest::Base) do
#         api url: 'test_url'
#         attr_accessor :name
#       end
#     )
#   end
#
# describe '.configure' do
#   it 'configures' do
#     Object.const_set(
#       'TestClass',
#       Class.new(ActiveRest::Base) do
#         api url: 'test_url'
#       end
#     )
#     expect(TestClass.api_url).to eq('test_url')
#
#     Object.const_set(
#       'TestClass2',
#       Class.new(TestClass) do
#         api path: 'test_path'
#       end
#     )
#     expect(TestClass2.api_url).to eq('test_url')
#     expect(TestClass2.api_path).to eq('test_path')
#
#     expect(ActiveRest::Base.method_defined?(:api_url)).to eq(false)
#   end
# end
#
# describe '.all' do
#   it 'must make get request' do
#     TestClass.all
#   end
# end

#   describe '#serialize' do
#     it 'must serialize' do
#       # obj = TestClass.new
#       # puts TestClass.attribute_names
#       # puts obj.to_json
#       # puts obj.attributes.to_s
#     end
#   end
#
#   describe '#deserialize' do
#     it 'must deserialize' do
#     end
#   end
# end

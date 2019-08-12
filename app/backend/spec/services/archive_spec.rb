# require 'rails_helper'

# describe Backend::Concerns::Services::Collectable::Archive do
#   let(:service_class) {
#     Class.new do
#       include Backend::Concerns::Services::Collectable
#       attr_accessor :collect_parameter
#     end
#   }
#   let(:service) { service_class.new }

#     before do
#       allow(service).to receive(:collect_parameter).and_return(parameter)
#     end

#   describe '#collect_from_archive' do
#     let(:parameter)      { double(archive_url: 'https://example.com/') }
#     let(:archive_binary) { File.binread('spec/fixtures/files/tweets.zip') }

#     before do
#       allow(service).to receive(:download_archive).and_return(archive_binary)
#     end

#     it 'collects tweets' do
#       expect { |b| service.collect_from_archive(&b) }.to yield_control.exactly(28)
#       expect do
#         service.collect_from_timeline do |status|
#           expect(status['id']).to be_kind_of String
#           expect(status['created_at']).to be_kind_of DateTime
#           expect(status['in_reply_to_user_id']).to be_kind_of(String).or be_nil
#           expect(status['favorite_count']).to be_kind_of Integer
#         end
#       end
#     end
#   end
# end

require 'rails_helper'

describe CollectFromTimelineService do
  describe '.collect!' do
    let(:user)      { build :cohakim }
    let(:parameter) { build :parameter }
    let(:order)     { build :order, user: user, parameter: parameter }

    it 'collects tweets' do
      VCR.use_cassette('timeline') do
        timeline = []
        described_class.collect!(order.credentials, order.collect_params) do |status|
          expect(status.id).to be_kind_of Integer
          expect(status.created_at).to be_kind_of Time
          expect(status.in_reply_to_user_id).to be_kind_of(Integer).or be_nil
          expect(status.favorite_count).to be_kind_of(Integer)
          timeline << status
        end
        expect(timeline.count).to eq 2975
      end
    end

    context 'when protect_reply is enabled' do
      let(:parameter) { build :parameter, protect_reply: true }

      it 'collects tweets' do
        VCR.use_cassette('timeline') do
          timeline = []
          described_class.collect!(order.credentials, order.collect_params) do |status|
            expect(status.in_reply_to_user_id).to be_nil
            timeline << status
          end
          expect(timeline.count).to eq 2931
        end
      end
    end

    context 'when protect_favorite is enabled' do
      let(:parameter) { build :parameter, protect_favorite: true }

      it 'collects tweets' do
        VCR.use_cassette('timeline') do
          timeline = []
          described_class.collect!(order.credentials, order.collect_params) do |status|
            expect(status.favorite_count).to eq 0
            timeline << status
          end
          expect(timeline.count).to eq 2685
        end
      end
    end

    context 'when signedin_at is enabled' do
      let(:parameter) { build :parameter, signedin_at: Time.zone.parse('2019-01-01 00:00:00') }

      it 'collects tweets' do
        VCR.use_cassette('timeline') do
          timeline = []
          described_class.collect!(order.credentials, order.collect_params) do |status|
            expect(status.created_at).to be < parameter.signedin_at
            timeline << status
          end
          expect(timeline.count).to eq 1851
        end
      end
    end

    context 'when collect_from is enabled' do
      let(:parameter) { build :parameter, collect_from: Date.parse('2019-01-01') }

      it 'collects tweets' do
        VCR.use_cassette('timeline') do
          timeline = []
          described_class.collect!(order.credentials, order.collect_params) do |status|
            expect(status.created_at).to be >= parameter.collect_from
            timeline << status
          end
          expect(timeline.count).to eq 1123
        end
      end
    end

    context 'when collect_to is enabled' do
      let(:parameter) { build :parameter, collect_to: Date.parse('2019-01-01') }

      it 'collects tweets' do
        VCR.use_cassette('timeline') do
          timeline = []
          described_class.collect!(order.credentials, order.collect_params) do |status|
            expect(status.created_at).to be < parameter.collect_to
            timeline << status
          end
          expect(timeline.count).to eq 1852
        end
      end
    end
  end
end

require 'spec_helper'

require_relative '../../lib/tricle/metric'

describe Tricle::Metric do
  let(:metric) { Tricle::Metric.new }

  describe '#size_for_range' do
    it "should raise an exception if #items_for_range isn't overridden" do
      expect { metric.size_for_range(Time.now.yesterday, Time.now) }.to raise_error
    end

    it "should use the number of items by default" do
      allow(metric).to receive(:items_for_range) { [1,2,3] }
      expect(metric.size_for_range(Time.now.yesterday, Time.now)).to eq(3)
    end
  end

  describe '#inspect' do
    before do
      allow(metric).to receive(:total?) { true }
      allow(metric).to receive(:total) { '123' }
      allow(metric).to receive(:size_for_range) { '456' }
      allow(metric).to receive(:items_for_range) { ['a'] }
    end

    it 'outputs total' do
      expect {
        metric.inspect
      }.to output(/123/).to_stdout
    end

    it 'outputs size_for_range' do
      expect {
        metric.inspect
      }.to output(/456/).to_stdout
    end

    it 'outputs items_for_range' do
      expect {
        metric.inspect
      }.to output(/\- a/).to_stdout
    end
  end

end

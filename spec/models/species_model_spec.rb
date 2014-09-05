require 'spec_helper'

describe "Species" do
  let (:species) { FactoryGirl.create :species }

  it 'should be a species object' do
    expect(species).to be_a(Species)
  end

  it 'should have a :genus_id attribute' do
    expect(species).to respond_to(:genus_id)
  end

  it 'should have a :common_name attribute' do
    expect(species).to respond_to(:common_name)
  end

  it 'should have a :scientific_name attribute' do
    expect(species).to respond_to(:scientific_name)
  end

  it 'should have a :red_list_status attribute' do
    expect(species).to respond_to(:red_list_status)
  end

  it 'should have a :population_trend attribute' do
    expect(species).to respond_to(:population_trend)
  end
end
# frozen_string_literal: true

require 'spec_helper'
require_relative '../../tasks/resolve_reference.rb'

describe EnvReference do
  let(:var) { 'SPEC_VAR' }
  let(:value) { 'bolt' }

  around(:each) do |example|
    ENV[var] = value
    example.run
    ENV.delete(var)
  end

  it 'loads the environment variable' do
    expect(subject.task(var: var)).to eq(value: value)
  end

  it 'raises an error when the environment variable is unset' do
    ENV.delete(var)
    expect { subject.task(var: var) }.to raise_error(TaskHelper::Error, /no value to load/)
  end
end

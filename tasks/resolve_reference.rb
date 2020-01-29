#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../ruby_task_helper/files/task_helper.rb"

class EnvReference < TaskHelper
  def task(**opts)
    value = ENV[opts[:var]]

    unless value
      msg = "Environment variable '#{opts[:var]}' is not set, no value to load"
      raise TaskHelper::Error.new(msg, 'bolt-plugin/validation-error')
    end

    { value: value }
  end
end

if $PROGRAM_NAME == __FILE__
  EnvReference.run
end

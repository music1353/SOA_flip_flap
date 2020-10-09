# frozen_string_literal: true

require 'csv'
require 'yaml'

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv.split("\n").map { |line| line.split("\t") }
    header = rows[0]
    records = rows[1..-1]
    @data = records.map do |record|
      record.map.with_index { |item, idx| [header[idx], item] }.to_h
    end

    print @data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    raise 'ERROR: please load data' if @data.nil?

    keys_array = @data.first.keys
    records = @data.map { |record| record.values.join("\t") }

    ([keys_array.join("\t")] + records).join("\n") + "\n"
  end
end

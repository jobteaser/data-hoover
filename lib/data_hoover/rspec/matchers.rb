RSpec::Matchers.define :track do |event|
  supports_block_expectations

  match do |api|
    partial_expectation = expect_any_instance_of(DataHoover::Nozzle).to receive(:absorb)

    if @chained_method_clauses.any?
      partial_expectation.with(event, @payload)
    else
      partial_expectation.with(event, anything)
    end

    api.call

    true
  end

  chain :with do |payload|
    @payload = payload
  end
end

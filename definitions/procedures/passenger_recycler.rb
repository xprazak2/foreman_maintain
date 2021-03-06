class Procedures::PassengerRecycler < ForemanMaintain::Procedure
  metadata do
    description 'Perform Passenger memory recycling'

    confine do
      execute?('which scl') && execute?('which passenger-recycler')
    end
  end

  def run
    execute!('scl enable tfm -- ruby passenger-recycler')
  end
end

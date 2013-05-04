module Snapshot
  include HTTParty
  def save_snapshot(url)
    HTTParty.get(url)
  end
end
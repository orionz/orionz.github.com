require 'json'

class GenericMonitor < Scout::Plugin
  def get_data
    cmd = option(:external_cmd) || "/home/ops/scout/ops_to_json"
    json_data = IO.popen(cmd, "r+") do |as|
      as.close_write
      as.read
    end
    JSON.load(json_data)
  end

  def build_report
    data = get_data
    report = get_data["report"]
    report["baseline"] = 1
    report(get_data["report"])
  end
end

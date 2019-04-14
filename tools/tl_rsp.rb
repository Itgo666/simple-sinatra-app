module Ns
  module TlRsp
    def halt_ok (data)
      {
          :code => 0,
          :msg => 'succ',
          :data => data
      }.to_json
    end

    def halt_err (code, msg)
      {
          :code => code,
          :msg => msg
      }.to_json
    end

  end
end
